# Maza with Docker

All-in-one image based on Alpine: Maza and Dnsmasq in a single container, ready to be used as the DNS server of your network.

- Dnsmasq blocks the domains and their sub-domains (wildcards).
- Open ports: `53/tcp`, `53/udp` and `67/udp`.
- The list is updated when the container starts and once a day (03:00, container time).

## Start

Clone the repository and start the container from its root folder:

```sh
git clone https://github.com/tanrax/maza-ad-blocking.git
cd maza-ad-blocking
docker compose up -d --build
```

Check that it works:

```sh
dig @127.0.0.1 doubleclick.net
```

The answer must be `127.0.0.1`.

Then configure your devices or your router to use the IP of the machine running the container as DNS server.

## Configuration

The configuration is stored in the `config` folder, next to `compose.yaml` (`/etc/maza` in the container). It is created the first time the container starts. On Linux the files belong to root, so edit them with `sudo`.

```
config/
├── custom-domains   # Domains to block
├── ignore           # Domains not to block
└── dnsmasq.d/       # Extra Dnsmasq configuration (*.conf)
```

Equivalence with the options of the main README:

| Main README | Docker |
|---|---|
| Alternative DNS list (line 8 of `maza`) | `URL_DNS_LIST_CUSTOM` environment variable |
| `/root/.config/maza/custom-domains` | `config/custom-domains` |
| `/root/.config/maza/ignore` | `config/ignore` |
| Auto update with `cron` | Included, every day at 03:00 |
| Bonus: dnsmasq is in charge of solving all DNS | `DNS_SERVERS` environment variable |
| Bonus: dnsmasq have `localhost` domains | A `.conf` file in `config/dnsmasq.d/` |

Dnsmasq only loads the list when it starts. After any change in `config`, update the list and restart Dnsmasq (the container starts it again in a second):

```sh
docker exec maza sh -c 'maza update && pkill dnsmasq'
```

After changing `compose.yaml`, recreate the container:

```sh
docker compose up -d
```

### Alternative DNS list

```yaml
environment:
  - URL_DNS_LIST_CUSTOM=https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
```

### Upstream DNS servers

By default Dnsmasq forwards the queries to the DNS of the host. To use other servers, separate them with commas:

```yaml
environment:
  - DNS_SERVERS=208.67.222.222,208.67.220.220
```

### Extra Dnsmasq configuration

Any `.conf` file in `config/dnsmasq.d/` is loaded by Dnsmasq. For example, to resolve all `.localhost` domains, create `config/dnsmasq.d/localhost.conf`:

```
address=/.localhost/127.0.0.1
```

## Commands

```sh
# Status
docker exec maza maza status

# Update the list
docker exec maza sh -c 'maza update && pkill dnsmasq'

# Stop blocking
docker exec maza sh -c 'maza stop && pkill dnsmasq'

# Start blocking again
docker compose restart
```

## Port 53 already in use

Some Linux distributions run `systemd-resolved` on port 53. Disable its stub listener or change the published port in `compose.yaml`.
