sudo apt install git
git config --global user.email "kruyerl@gmail.com" && git config --global user.name "kruyerl"

ssh-keygen -t ed25519 -C "kruyerl@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
echo "Copy the above key to https://github.com/settings/keys "
read -p "push enter to continue"
read gitcontinue
