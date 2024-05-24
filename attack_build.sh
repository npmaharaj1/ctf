#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Insufficient Permissions, maybe run as root?"
  exit
fi

RED='\033[0;31m'
NC='\033[0m' # No Color

clear
printf "${RED}Installing Dependencies${NC}\n"
apt update
apt install -y nmap ffuf hydra openssh-server
wget https://raw.githubusercontent.com/npmaharaj1/ctf/main/passwd_list.txt
wget https://raw.githubusercontent.com/v0re/dirb/master/wordlists/common.txt
