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
- [x] ip
- [x] build-essential
- [X] strings
- [x] xxd
- [ ] vscode

### WEB

- [x] netcat
- [x] socat
- [x] tcpdump
- [x] iperf3
- [x] wireshark
- [x] nmap
- [ ] gobuster
- [x] burpsuite

### WIFI

- [x] aircrack-ng

### EXPLOITATION
- [ ] metasploit

### HASHES
- [x] hashcat
- [x] john

### REVERSE
- [x] gdb
- [ ] gef

### STEG
- [ ] ciphey

### PROGRAMMATION
- [x] python3
- [x] python3-pip
- [x] python-is-python3

https://portswigger-cdn.net/burp/releases/download?product=community&version=2023.2.4&type=Linux
