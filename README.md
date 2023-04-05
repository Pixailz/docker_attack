# docker_attack
Docker for pentesting

## fix python3.10-minimal installation error

1. edit /var/snap/docker/current/config/daemon.json and replace "overlay2" with "vfs" for the storage-driver
2. run sudo snap restart docker

## PACKAGE

### BASE

- [x] vim
- [x] tmux
- [x] git
- [x] wget
- [x] curl
- [ ] ip
- [ ] build-essential
- [ ] vscode

### WEB

- [x] netcat
- [x] tcpdump
- [x] iperf3
- [x] wireshark
- [x] nmap
- [ ] gobuster
- [ ] burpsuite

### WIFI

- [ ] aircrack-ng

### EXPLOITATION
- [ ] metasploit

### HASHES
- [ ] hashcat
- [ ] john

### REVERSE
- [ ] gdb

### STEG
- [ ] ciphey

### PROGRAMMATION
- [ ] python3
- [ ] python3-pip
- [ ] python-is-python3

https://portswigger-cdn.net/burp/releases/download?product=community&version=2023.2.4&type=Linux
