echo "seeding"

mkdir -p ~/.config

# fonts
ln -sf ~/dotfiles/assets/fonts ~/.fonts
fc-cache -f -v

# wallpapers
ln -sf ~/dotfiles/assets/wallpapers ~/Pictures/Wallpapers

# themes
ln -sf ~/dotfiles/assets/themes ~/.themes

# icons/cursors
ln -sf ~/dotfiles/assets/icons ~/.icons

# zshrc
ln -sf ~/dotfiles/configs/zshrc ~/.zshrc

# tmux
ln -sf ~/dotfiles/configs/tmux.conf ~/.tmux.conf

# nvim
ln -sf ~/dotfiles/configs/nvim ~/.config/nvim

echo "seeding complete"
