echo "Installing"

sudo apt update && sudo apt upgrade -y
sudo apt install -y software-properties-common build-essential
sudo apt install -y wget
sudo apt install -y tmux
sudo apt install -y unzip
sudo apt install -y fuse
sudo apt install -y libfuse2
sudo apt install -y ranger
sudo apt install -y bat
sudo apt install -y tree
sudo apt install -y lsd
sudo apt install -y ripgrep
sudo apt install -y fzf
sudo apt install -y fd-find
sudo apt install -y make
sudo apt install -y gcc
sudo apt install -y ffmpeg
sudo apt install -y 7zip
sudo apt install -y jq
sudo apt install -y poppler-utils
sudo apt install -y zoxide
sudo apt install -y imagemagick

sudo apt autoremove
sudo apt autoclean

# Set up Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
. "$HOME/.cargo/env"
rustup update

# Install Yazi
cargo install --locked yazi-fm yazi-cli

# Configure Git
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install Nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim

# Install Yazi
cargo install --locked --git https://github.com/sxyazi/yazi.git yazi-fm yazi-cli

# Install Zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# Install Fast Node Manager
curl -fsSL https://fnm.vercel.app/install | bash --skip-shell

source ~/.zshrc

echo "Install Complete"
