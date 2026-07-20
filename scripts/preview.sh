#!/usr/bin/env bash
# Launches this repo as an isolated Neovim config via NVIM_APPNAME, so it
# never touches your real ~/.config/nvim, plugin data, or state.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
APPNAME="nvim-config-preview"
CONFIG_LINK="$HOME/.config/$APPNAME"

if [ ! -e "$CONFIG_LINK" ]; then
  ln -s "$REPO_DIR" "$CONFIG_LINK"
elif [ ! -L "$CONFIG_LINK" ] || [ "$(readlink "$CONFIG_LINK")" != "$REPO_DIR" ]; then
  echo "error: $CONFIG_LINK exists and doesn't point at $REPO_DIR" >&2
  exit 1
fi

exec env NVIM_APPNAME="$APPNAME" nvim "$@"
