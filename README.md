# docker_cybersec
Docker for CyberSecurizing all the ting

## HOWTO

1. copy and paste [./.env.template](./.env.template) to .env
2. make your own choice
3. `make` the docker once (can take a while)
4. enjoy

## TODO

1. have the choice to choose modules
2. make the prompt according to the side you choose
   1. have red tool, make the prompt red
   2. have blue tool, make the prompt blue
   3. have both tool, make the prompt purple
   4. etc

## PACKAGE

- category
  1. base
  2. prog
  3. web
  4. crack
  5. wifi
  6. exploitation
  7. reverse
  8. steg

- team
  1. 🔴 red: attack
  2. 🔵 blue: defend
  3. 🟢 green: build
  4. ⚫ None: None

- available
  1. ❌
  2. ✅

- from:
  1. apt
  2. curl
  3. git

|name              |category      |team |available|from |
|:--------------:  |:------------:|:---:|:-------:|:---:|
|vim               |base          |🟢   |✅       |apt  |
|tmux              |base          |🟢   |✅       |apt  |
|git               |base          |🟢   |✅       |apt  |
|wget              |base          |🔴   |✅       |apt  |
|curl              |base          |🔴   |✅       |apt  |
|ip                |base          |🟢   |✅       |apt  |
|strings           |base          |🔵   |✅       |apt  |
|xxd               |base          |🔵   |✅       |apt  |
|file              |base          |🔵   |✅       |apt  |
|chrome            |base          |⚫   |✅       |deb  |
|                  |              |     |         |     |
|build-essential   |prog          |🟢   |✅       |apt  |
|python3           |prog          |🟢   |✅       |apt  |
|python3-pip       |prog          |🟢   |✅       |apt  |
|python-is-python3 |prog          |🟢   |✅       |apt  |
|gdb               |prog          |🔵   |✅       |apt  |
|gnome-terminal    |prog          |🟢   |✅       |apt  |
|jdk-20            |prog          |🟢   |✅       |deb  |
|vscode            |prog          |🟢   |✅       |deb  |
|                  |              |     |         |     |
|nmap              |web           |🔴   |✅       |apt  |
|netcat-openbsd    |web           |🔴   |✅       |apt  |
|wireshark         |web           |🔴   |✅       |apt  |
|gobuster          |web           |🔴   |✅       |git  |
|burpsuite         |web           |🔴   |✅       |jar  |
|net-tools         |web           |🟢   |✅       |apt  |
|iperf3            |web           |🟢   |✅       |apt  |
|tcpdump           |web           |🟢   |✅       |apt  |
|iproute2          |web           |🟢   |✅       |apt  |
|iputils-ping      |web           |🟢   |✅       |apt  |
|                  |              |     |         |     |
|hashcat           |crack         |🔴   |✅       |apt  |
|john              |crack         |🔴   |✅       |apt  |
|hydra             |crack         |🔴   |✅       |apt  |
|                  |              |     |         |     |
|aircrack-ng       |wifi          |🔴   |✅       |apt  |
|wifite            |wifi          |🔴   |❌       |???  |
|                  |              |     |         |     |
|metasploit        |exploitation  |🔴   |❌       |curl |
|                  |              |     |         |     |
|gef               |reverse       |🔵   |❌       |git  |
|readelf           |reverse       |🔵   |✅       |apt  |
|objdump           |reverse       |🔵   |✅       |apt  |
|ghidra            |reverse       |🔵   |✅       |git  |
|r2                |reverse       |🔵   |✅       |git  |
|                  |              |     |         |     |
|ciphey            |steganohraphy |🔵   |❌       |git  |
|binwalk           |steganohraphy |🔵   |✅       |apt  |
|exiftool          |steganohraphy |🔵   |✅       |apt  |

## SUCESSFULL BUILD TIME

|date      |time   |size  |stage|
|:--------:|:-----:|:----:|:---:|
|09/04/2023| 373.2s|5.17GB|15   |
|09/04/2023| 602.4s|5.17GB|15   |
|          |       |      |     |
|10/04/2023| 524.7s| 9.8GB|17   |
