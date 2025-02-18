echo "seeding"

mkdir -p ~/.config

# fonts
#ln -sf ~/dotfiles/assets/fonts ~/.fonts
#fc-cache -f -v

# wallpapers
# ln -sf ~/repos/dotfiles/assets/wallpapers ~/Pictures/Wallpapers

# themes
# ln -sf ~/repos/dotfiles/assets/themes ~/.themes

# icons/cursors
# ln -sf ~/repos/dotfiles/assets/icons ~/.icons

# zshrc
ln -sf ~/repos/dotfiles/configs/zshrc ~/.zshrc

# tmux
ln -sf ~/repos/dotfiles/configs/tmux.conf ~/.tmux.conf

# nvim
ln -sf ~/repos/dotfiles/configs/nvim ~/.config/nvim

echo "seeding complete"
