echo "Installing"
sudo apt update && sudo apt upgrade -y

sudo apt install -y software-properties-common build-essentials
sudo apt install -y git curl wget tmux unzip  

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim

# Configure Git
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git config --global user.email "kruyerl@gmail.com"
git congig --global user.name "kruyerl"
ssh-keygen -t ed25519 -C "kruyerl@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519
echo "Copy the above key to https://github.com/settings/keys "
read -p "push enter to continue"
read gitcontinue

#set up node
curl -fsSL https://fnm.vercel.app/install | bash
source ~/.zshrc
fnm list-remote
echo which version would you like to install?
read nodevinput
fnm install $nodevinput

npm install -g parcel-bundler

sudo apt autoremove && sudo apt autoclean
source ~/.zshrc

echo "Install Complete"
