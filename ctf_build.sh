#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Insufficient Permissions, maybe run as root?"
  exit
fi

if imvirt | grep -q "Physical"; then
  echo "Virtual environment detected (may not be accurate)"
else
  echo "Physical environment (or virtual environment not detectable)"
fi

RED='\033[0;31m'
NC='\033[0m' # No Color

clear
printf "${RED}Installing Dependencies${NC}\n"
apt update
apt install -y git python3 apache2 openssh-server
printf "${RED}Cloning Respository${NC}\n"
git clone https://github.com/npmaharaj1/ctf

printf "${RED}Copying Files${NC}\n"
cp -r ctf/admin /var/www/html
cp -r ctf/index.html /var/www/html

printf "${RED}Setting up User${NC}\n"
useradd -m stevenirate
echo -e "georgia\ngeorgia" | passwd stevenirate  
echo "a7ba7425c4366547f458ac75cba3e4b4" > /home/stevenirate/flag.txt

systemctl restart ssh
systemctl status ssh

printf "\n\nYour Attack IP Address is "
hostname -I
printf "You no longer need to be at this terminal, happy hacking!\n"
