#/bin/bash

#updates & drivers
echo "[-] Update and install base software & drivers [-]"
sudo apt update && sudo apt upgrade -y 
sudo apt update && sudo apt dist-upgrade
sudo apt update && sudo apt full-upgrade
sudo ubuntu-drivers autoinstall

#git
sudo apt install git
git config --global user.email "kruyerl@gmail.com"
git config --global user.name "Luke Kruyer"
git clone https://github.com/kruyerl/.dotfiles.git ~/.dotfiles

# CLI TOOLS
echo "[-] Installing necessities [-]"
sudo apt install git curl zsh snapd caffeine gparted neofetch htop tmux -y
sudo apt install fzf ripgrep universal-ctags silversearcher-ag fd-find
sudo apt install s-tui stress htop neofetch
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf

#gnome extras
echo "[-] Installing gnome stuff [-]"
sudo apt install gnome-tweak-tool gnome-shell-extensions -y

#software allowances
echo "[-] Enabling software things [-]"
sudo apt install software-properties-common ubuntu-restricted-extras

#ohmyzsh
echo "[-] Installing zsh [-]"	
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 
rm -rf ~/.zshrc && ln -s ~/.dotfiles/.zshrc ~/.zshrc

#setup javascript
echo "[-] Installing Javascript [-]"
curl -fsSL https://fnm.vercel.app/install | bash
source .zshrc

#setup python
echo "[-] Installing Python [-]"
sudo apt update && sudo apt install python2 python3 -y
sudo apt update && sudo apt install python3-venv python3-pip -y

#fonts
echo "[-] Installing Fonts [-]"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
unzip ~/FiraCode.zip -d ~/.fonts
fc-cache -fv
rm -rf ~/Firacode.zip

#set up ssh
echo "[-] Setting up SSH [-]"
sudo apt update && sudo apt install openssh-server -y
sudo ufw allow ssh
ssh-keygen -t rsa -b 4096 -C "kruyerl@gmail.com"

#raspberrypi system stats
curl -sSL https://raw.githubusercontent.com/PierreKieffer/pitop/master/install/install_pitop64.sh | bash

#editors
echo "[-] Installing Code Editors [-]"
#sudo add-apt-repository ppa:neovim-ppa/unstable
#sudo apt update && sudo apt install neovim -y
sudo snap install --edge nvim --classic
ln -s ~/.dotfiles/nvim ~/.config/nvim


#software
echo "[-] Installing Additional Software [-]"
sudo apt update && sudo apt install vlc zoom -y

#cleanups
echo "[-] Cleaning Up [-]"
sudo apt autoremove && sudo apt autoclean


