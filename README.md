# Maza ad blocking 

Simple and efficient local ad blocking throughout the network.

<img alt="maza logo" src="media/maza.png" width="500">

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

- bash 4.0 or higher
- curl

Then you do this.

``` bash
curl -o maza https://raw.githubusercontent.com/tanrax/maza-ad-blocking/master/maza
chmod +x maza
sudo mv maza /usr/local/bin
```

## ⚠️ CAUTION

- Only compatible with Linux and OSX operating systems.
- Remember to make a backup copy of `/etc/hosts` in case of unforeseen circumstances, neither the project nor its author will be responsible for any possible repercussions derived from not carrying out this action.
