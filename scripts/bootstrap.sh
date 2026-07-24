#!/usr/bin/env bash
set -euo pipefail

DOTFILES_REPO_HTTPS="${DOTFILES_REPO_HTTPS:-https://github.com/kruyerl/Dotfiles.git}"
DOTFILES_REPO_SSH="${DOTFILES_REPO_SSH:-git@github.com:kruyerl/Dotfiles.git}"
DOTFILES_BRANCH="${DOTFILES_BRANCH:-Main}"
REPOS_DIR="${REPOS_DIR:-$HOME/repos}"
DOTFILES_DIR="${DOTFILES_DIR:-$REPOS_DIR/dotfiles}"

print_usage() {
  cat <<EOF
Usage: $0 [--clone-only] [--help]

Bootstraps a new machine far enough to clone and start installing this dotfiles repo.

Default behavior:
  1. apt update/upgrade
  2. install git/curl/openssh-client
  3. configure git identity with prompts
  4. optionally create an SSH key
  5. create ~/repos
  6. clone or update the dotfiles repo into ~/repos/dotfiles
  7. optionally switch origin to SSH
  8. optionally run ./scripts/systemInit.sh from the cloned repo

Options:
  --clone-only   Stop after cloning/updating the repo
  --help         Show this help
EOF
}

CLONE_ONLY=0
while [[ ${#@} -gt 0 ]]; do
  case "$1" in
    --clone-only) CLONE_ONLY=1; shift ;;
    -h|--help) print_usage; exit 0 ;;
    *) echo "Unknown arg: $1"; print_usage; exit 1 ;;
  esac
done

prompt_default() {
  local prompt="$1"
  local default_value="$2"
  local response
  if [ -n "$default_value" ]; then
    read -r -p "$prompt [$default_value]: " response
    printf '%s' "${response:-$default_value}"
  else
    read -r -p "$prompt: " response
    printf '%s' "$response"
  fi
}

confirm() {
  local prompt="$1"
  local default_answer="${2:-Y}"
  local suffix="[Y/n]"
  if [[ "$default_answer" =~ ^[Nn]$ ]]; then
    suffix="[y/N]"
  fi

  local response
  read -r -p "$prompt $suffix " response
  response="${response:-$default_answer}"
  [[ "$response" =~ ^[Yy]$ ]]
}

ensure_base_packages() {
  echo "Updating apt metadata and base packages"
  sudo apt update -y
  sudo apt upgrade -y
  sudo apt install -y git curl openssh-client
}

configure_git_identity() {
  local current_name current_email new_name new_email
  current_name="$(git config --global user.name || true)"
  current_email="$(git config --global user.email || true)"

  echo
  echo "Configuring git identity"
  new_name="$(prompt_default "Git user.name" "$current_name")"
  new_email="$(prompt_default "Git user.email" "$current_email")"

  if [ -n "$new_name" ]; then
    git config --global user.name "$new_name"
  fi
  if [ -n "$new_email" ]; then
    git config --global user.email "$new_email"
  fi
}

setup_ssh_key() {
  local key_path="$HOME/.ssh/id_ed25519"
  local key_email

  mkdir -p "$HOME/.ssh"
  chmod 700 "$HOME/.ssh"

  if [ -f "$key_path" ]; then
    echo
    echo "Existing SSH key found at $key_path"
    if confirm "Show the public key now?" Y; then
      cat "$key_path.pub"
      echo
    fi
    return 0
  fi

  if ! confirm "Create a new SSH key for Git hosting?" Y; then
    return 0
  fi

  key_email="$(git config --global user.email || true)"
  key_email="$(prompt_default "SSH key email/comment" "$key_email")"

  ssh-keygen -t ed25519 -C "$key_email" -f "$key_path"
  eval "$(ssh-agent -s)"
  ssh-add "$key_path"

  echo
  echo "Add this SSH public key to your Git hosting account:"
  cat "$key_path.pub"
  echo
  read -r -p "Press Enter after you have saved the key to your account..."
}

clone_or_update_repo() {
  mkdir -p "$REPOS_DIR"

  if [ -d "$DOTFILES_DIR/.git" ]; then
    echo "Dotfiles repo already exists at $DOTFILES_DIR"
    git -C "$DOTFILES_DIR" fetch --all --prune
    git -C "$DOTFILES_DIR" pull --ff-only
  else
    echo "Cloning dotfiles into $DOTFILES_DIR"
    git clone --branch "$DOTFILES_BRANCH" "$DOTFILES_REPO_HTTPS" "$DOTFILES_DIR"
  fi
}

switch_origin_to_ssh() {
  if [ ! -d "$DOTFILES_DIR/.git" ]; then
    return 0
  fi

  if confirm "Switch the dotfiles origin remote to SSH?" Y; then
    git -C "$DOTFILES_DIR" remote set-url origin "$DOTFILES_REPO_SSH"
    echo "Origin is now: $(git -C "$DOTFILES_DIR" remote get-url origin)"
  fi
}

run_repo_setup() {
  if [ "$CLONE_ONLY" -eq 1 ]; then
    echo
    echo "Clone-only mode complete. Next steps:"
    echo "  cd $DOTFILES_DIR && ./scripts/install.sh"
    echo "  cd $DOTFILES_DIR && ./scripts/setup.sh"
    echo
    echo "Note: after ./scripts/setup.sh links the repo-managed zsh config, new zsh shells will reuse a shared ssh-agent and should only ask for your SSH key passphrase once per login session."
    return 0
  fi

  if confirm "Run ./scripts/systemInit.sh from the cloned repo now?" Y; then
    bash "$DOTFILES_DIR/scripts/systemInit.sh"
    echo
    echo "If setup linked your zsh config, new zsh shells will now reuse a shared ssh-agent and should only ask for your SSH key passphrase once per login session."
  else
    echo "You can continue later with either:"
    echo "  cd $DOTFILES_DIR && ./scripts/systemInit.sh"
    echo "or the explicit phases:"
    echo "  cd $DOTFILES_DIR && ./scripts/install.sh"
    echo "  cd $DOTFILES_DIR && ./scripts/setup.sh"
    echo
    echo "After ./scripts/setup.sh links the repo-managed zsh config, new zsh shells will reuse a shared ssh-agent and should only ask for your SSH key passphrase once per login session."
  fi
}

ensure_base_packages
configure_git_identity
setup_ssh_key
clone_or_update_repo
switch_origin_to_ssh
run_repo_setup
