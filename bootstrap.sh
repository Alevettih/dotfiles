#!/usr/bin/env bash
RED='\033[0;31m'
NC='\033[0m' # No Color

echo ""
echo -e "${RED}Update system...${NC}"
echo ""
sudo apt-get update --yes       # Fetches the list of available updates
sudo apt-get upgrade --yes       # Strictly upgrades the current packages
sudo apt-get dist-upgrade --yes  # Installs updates (new ones)

echo ""
echo -e "${RED}Install system dependencies...${NC}"
echo ""
sudo apt-get install --yes \
  git \
  curl \
  ctags

echo ""
echo -e "${RED}Install slack...${NC}"
echo ""
sudo snap install slack --classic

echo ""
echo -e "${RED}Install git...${NC}"
echo ""
sudo apt-get install git --yes

echo ""
echo -e "${RED}Install skype...${NC}"
echo ""
sudo apt-get install -y apt-transport-https
curl https://repo.skype.com/data/SKYPE-GPG-KEY | sudo apt-key add -
echo "deb https://repo.skype.com/deb stable main" | sudo tee /etc/apt/sources.list.d/skypeforlinux.list
sudo apt-get update
sudo apt-get install --yes skypeforlinux

echo ""
echo -e "${RED}Install chrome...${NC}"
echo ""
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt-get update
sudo apt-get install --yes google-chrome-stable

echo ""
echo -e "${RED}Install telegram...${NC}"
echo ""
wget -O- https://telegram.org/dl/desktop/linux | sudo tar xJ -C /opt/
sudo ln -s /opt/Telegram/Telegram /usr/local/bin/telegram-desktop

echo ""
echo -e "${RED}Install node.js...${NC}"
echo ""
sudo apt-get install --yes nodejs gcc g++ make

echo ""
echo -e "${RED}Install Yarn...${NC}"
echo ""
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get install --yes yarn

echo ""
echo -e "${RED}Create projects directory${NC}"
echo ""
mkdir ~/Projects

echo ""
echo -e "${RED}Install WebStorm${NC}"
echo ""
wget -O ~/Downloads/Webstorm.tar.gz "https://www.jetbrains.com/webstorm/download/download-thanks.html?platform=linux"
tar xfz ~/Downloads/WebStorm.tar.gz -C /opt/
cd /opt/WebStorm/bin
bash ./webstorm.sh


echo ""
echo -e "${RED}Clone dotfiles project${NC}"
echo ""
cd ~/Projects
git clone https://github.com/alevettih/dotfiles.git

echo ""
echo -e "${RED}Create symbol links${NC}"
echo ""

echo -e "${RED}Create symbolic link for .editorconfig${NC}"
ln -s ~/Projects/dotfiles/.editorconfig ~/.editorconfig
echo -e "${RED}Create symbolic link for .gitconfig${NC}"
ln -s ~/Projects/dotfiles/.gitconfig ~/.gitconfig

echo -e "${RED}Create symbolic link for .ctags${NC}"
ln -s ~/Projects/dotfiles/.ctags ~/.ctags

echo -e "${RED}Create symbolic link for autostart applications${NC}"
ln -s ~/Projects/dotfiles/autostart/* ~/.config/autostart/

echo ""
echo -e "${RED}Run autoremove...${NC}"
echo ""
sudo apt autoremove --yes

echo ""
echo -e "${RED}Done...${NC}"
echo ""
