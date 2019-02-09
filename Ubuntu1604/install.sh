# Custom install for Ubuntu 16.04
# Last updated: 10/05/2018

# Define colors used in the script
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

PKG_TO_INSTALL="vim tmux xsel curl openssh-server"

printf "${GREEN}Initial setup for Ubuntu 16.04${NC}\n"

# apt update
sudo apt update
if [ $? -ne 0 ]; then
	printf "${RED}Failed${NC}\"sudo apt update\". Aborting.\"${NC}\n"
	exit;
fi
printf "${GREEN}OK    ${NC}\"sudo apt update\"${NC}\n"

# apt upgrade
sudo apt upgrade
if [ $? -ne 0 ]; then
	printf "${RED} Failed \"sudo apt upgrade. Aborting.\"${NC}\n"
	exit;
fi
printf "${GREEN}OK    ${NC}\"sudo apt upgrade\"${NC}\n"

sudo apt install ${PKG_TO_INSTALL}
if [ $? -ne 0 ]; then
	printf "${RED} Failed \"sudo apt ${PKG_TO_INSTALL}\"${NC}\n"
	exit;
fi
printf "${GREEN}OK    ${NC}\"sudo apt install ${PKG_TO_INSTALL}\"${NC}\n"

# install atom
sudo add-apt-repository ppa:webupd8team/atom
sudo apt-get update
sudo apt-get install atom
if [ $? -ne 0 ]; then
	printf "${RED} Failed \"sudo apt install atom\"${NC}\n"
	exit;
fi
printf "${GREEN}OK    ${NC}\"sudo apt install atom\"${NC}\n"

# install caffeine
sudo add-apt-repository ppa:caffeine-developers/ppa && sudo apt-get update && sudo apt-get install caffeine
sudo apt-get update
if [ $? -ne 0 ]; then
	printf "${RED} Failed \"sudo apt install caffeine\"${NC}\n"
	exit;
fi
printf "${GREEN}OK    ${NC}\"sudo apt install caffeine\"${NC}\n"

# install chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - && echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list && sudo apt-get update && sudo apt-get install google-chrome-stable
if [ $? -ne 0 ]; then
	printf "${RED} Failed \"sudo apt install chrome\"${NC}\n"
	exit;
fi
printf "${GREEN}OK    ${NC}\"sudo apt install chrome\"${NC}\n"

# install bash_profile
if [ -f ~/.bash_profile ]; then
	printf "${YELLOW}WARN  ${NC}\"~/.bash_profile exists! Backing up at ~/.bash_profile.settings_backup\"${NC}\n"
	mv ~/.bash_profile ~/.bash_profile.settings_backup
fi
cp ./bash_profile ~/.bash_profile
printf "${GREEN}OK    ${NC}Copying bash_profile to ~/.bash_profile done\n"

# install bash_aliases
if [ -f ~/.bash_aliases ]; then
	printf "${YELLOW}WARN  ${NC}\"~/.bash_aliases exists! Backing up at ~/.bash_aliases.settings_backup\"${NC}\n"
	mv ~/.bash_aliases ~/.bash_aliases.settings_bakcup
fi
cp ./bash_aliases ~/.bash_aliases
printf "${GREEN}OK    ${NC}Copying bash_aliases to ~/.bash_aliases done\n"

printf "${GREEN}Done installing${NC}\n"
