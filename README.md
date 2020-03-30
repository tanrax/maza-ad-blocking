## 🥇 Maza was Top 1 in Hacker News

Comments: https://news.ycombinator.com/item?id=22717650

# Maza ad blocking - Like Pi-hole but local and using your operating system

<img alt="demo" src="media/demo.gif">

Simple, native and efficient local advertising blocker. Compatible with OSX and Linux.

<img alt="maza logo" src="media/maza.png" width="500">

- You don't have to install any browser extensions or applications, you just use the tools of your operating system.
- You update the list of DNS to be blocked with a single stroke.
- Opensource.
- Just bash.

## 🏃‍Run

### 📡 Update database 

``` bash
maza update 
```

### 🔨 Start

``` bash
sudo maza start 
```

### 🛠 Stop

``` bash
sudo maza stop 
```

### ⚖️ Status

``` bash
maza status 
```

## ⚙️ Install 

### 👀 Requirements 

- **bash** 4.0 or higher
- **curl**
- Only OSX users, **gsed**: `brew install gnu-sed`

Then you do this.

``` bash
curl -o maza https://raw.githubusercontent.com/tanrax/maza-ad-blocking/master/maza && chmod +x maza && sudo mv maza /usr/local/bin
```

Optional but recommended, make a backup of your hosts file.

``` bash
sudo cp /etc/hosts /etc/hosts.backup
```

## 🔪 Uninstall

``` bash
sudo rm /usr/local/bin/maza && sudo rm -r ~/.maza
```

## DNSMASQ

Unfortunately the hosts file does not support sub-domains (wildcards), which is necessary to correctly filter all DNS. You will need to install locally a server for that purpose, Maza supports the Dnsmasq format. Here's an example for OSX.

### 1 Install

```bash
brew install dnsmasq
```

### 2 Configure

Edit the file.

```
/usr/local/etc/dnsmasq.conf
```

Add the following lines.

```
conf-file=(your user path)/.maza/dnsmasq.conf
```

Start DNSMASQ.

```bash
sudo brew services stop dnsmasq
sudo brew services start dnsmasq
```

### 3 Tell your OS to use your DNS server

Delete the list of OSX DNS servers and add the 3 addresses. The first one will be your local server, and the other 2 belong to OpenDNS, which you can use any other.

```bash
127.0.0.1
208.67.222.222
208.67.220.220
```

Refresh your DNS cache

```bash
sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder
```

### Bonus: dnsmasq is in charge of solving all DNS

Add in confiigure file: `/usr/local/etc/dnsmasq.conf`

```
no-resolv
server=208.67.222.222
server=208.67.220.220
```

### Bonus: dnsmasq have test domains

If you want all your `.localhost` domains, for example, point to localhost add in confiigure file: `/usr/local/etc/dnsmasq.conf`

```
address=/.localhost/127.0.0.1
```

## ⚠️ CAUTION

- Only compatible with Linux and OSX operating systems.
- Remember to make a backup copy of `/etc/hosts` in case of unforeseen circumstances, neither the project nor its author will be responsible for any possible repercussions derived from not carrying out this action.
