#!/usr/bin/env bash

# Coding cockpit: neovim + pi + terminal in tmux
dev() {
  local session_name="${1:-$(basename "$PWD")}"

  if [[ -n "$TMUX" ]]; then
    echo "Already in a tmux session. Detach first or run from outside tmux."
    return 1
  fi

  if tmux has-session -t "$session_name" 2>/dev/null; then
    tmux attach-session -t "$session_name"
    return
  fi

  tmux new-session -d -s "$session_name" -c "$PWD" -x "$(tput cols)" -y "$(tput lines)"
  tmux split-window -v -t "$session_name" -c "$PWD" -l 20%
  tmux split-window -h -t "$session_name":1.1 -c "$PWD" -l 30%
  tmux send-keys -t "$session_name":1.1 'nvim' C-m
  tmux send-keys -t "$session_name":1.2 'pi' C-m
  tmux select-pane -t "$session_name":1.1
  tmux attach-session -t "$session_name"
}

# If the file is sourced (e.g. . dev.sh), don't run nic automatically.
# If executed directly, run dev with any provided arguments.
if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  dev "$@"
fi
