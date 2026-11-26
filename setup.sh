#!/usr/bin/env bash
# Usage: ./setup.sh [--no-brew]
set -eu

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}"

# 既存ファイル（シンボリックリンク以外）は .bak に退避してからリンクを張る
link() {
    local src="$DOTFILES/$1" dst="$2"
    mkdir -p "$(dirname "$dst")"
    if [[ -e "$dst" && ! -L "$dst" ]]; then
        mv "$dst" "$dst.bak.$(date +%Y%m%d%H%M%S)"
        echo "backup: $dst"
    fi
    ln -sfn "$src" "$dst"
    echo "link: $dst -> $src"
}

link zsh/.zshrc                "$HOME/.zshrc"
link git/.gitconfig            "$HOME/.gitconfig"
link vim/.vimrc                "$HOME/.vimrc"
link config/starship.toml      "$CONFIG/starship.toml"
link config/sheldon/plugins.toml "$CONFIG/sheldon/plugins.toml"
link config/atuin/config.toml  "$CONFIG/atuin/config.toml"

if [[ "${1:-}" != "--no-brew" ]] && command -v brew >/dev/null 2>&1; then
    brew bundle --file="$DOTFILES/Brewfile"
fi

if command -v sheldon >/dev/null 2>&1; then
    sheldon lock
fi
