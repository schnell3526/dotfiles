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
link config/mise/config.toml   "$CONFIG/mise/config.toml"
link claude/settings.json      "$HOME/.claude/settings.json"
link claude/CLAUDE.md          "$HOME/.claude/CLAUDE.md"

# Claude Code のグローバル skill は 1 つずつリンクする
# （~/.claude/skills/synced は claude.ai から同期されるディレクトリなので、skills ごとリンクはしない）
for skill in "$DOTFILES"/claude/skills/*/; do
    [[ -d "$skill" ]] || continue
    link "claude/skills/$(basename "$skill")" "$HOME/.claude/skills/$(basename "$skill")"
done
# dotfiles から消した skill のリンクを掃除
for dst in "$HOME"/.claude/skills/*; do
    if [[ -L "$dst" && ! -e "$dst" && "$(readlink "$dst")" == "$DOTFILES/claude/skills/"* ]]; then
        rm "$dst"
        echo "unlink: $dst"
    fi
done

if [[ "${1:-}" != "--no-brew" ]] && command -v brew >/dev/null 2>&1; then
    brew bundle --file="$DOTFILES/Brewfile"
fi

# CLI ツール（starship / fzf など）は mise で入れる
if command -v mise >/dev/null 2>&1; then
    mise install
    command -v zsh >/dev/null 2>&1 && zsh "$DOTFILES/zsh/gen-completions.zsh"
fi

if command -v sheldon >/dev/null 2>&1; then
    sheldon lock
fi
