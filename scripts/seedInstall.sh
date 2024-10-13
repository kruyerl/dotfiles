echo "Installing"

sudo apt update && sudo apt upgrade -y
sudo apt install -y software-properties-common build-essential
sudo apt install -y git curl wget tmux unzip fuse libfuse2
sudo apt autoremove && sudo apt autoclean

# Configure Git
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install Nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim

# Install Fast Node Manager
curl -fsSL https://fnm.vercel.app/install | bash --skip-shell

source ~/.zshrc

echo "Install Complete"
