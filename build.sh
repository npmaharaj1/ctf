#!/bin/bash

RED='\033[0;31m'
NC='\033[0m' # No Color

clear
printf "${RED}Installing Dependencies${NC}\n\n"
sudo apt update
sudo apt install git python3