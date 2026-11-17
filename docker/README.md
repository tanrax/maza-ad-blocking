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

## Alternative DNS list

Set the `URL_DNS_LIST_CUSTOM` environment variable in `compose.yaml`.

```yaml
environment:
  - URL_DNS_LIST_CUSTOM=https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
```

## Custom domains and ignore list

The configuration is stored in the `maza_data` volume (`/etc/maza` in the container). Edit the files `custom-domains` and `ignore`, then update the list:

```sh
docker exec maza sh -c 'maza update && pkill dnsmasq'
```

## Port 53 already in use

Some Linux distributions run `systemd-resolved` on port 53. Disable its stub listener or change the published port in `compose.yaml`.
