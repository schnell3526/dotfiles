### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# 補完
zinit ice wait'!0'; zinit load zsh-users/zsh-completions
autoload -Uz compinit && compinit
# タブ補完時に大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# 補完候補を一覧表示したとき、Tabや矢印で選択できるようにする
zstyle ':completion:*:default' menu select=1
# シンタックスハイライト
zinit ice wait'!0'; zinit load zsh-users/zsh-syntax-highlighting
# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=100000
setopt hist_ignore_dups


# ローカル設定ファイル
if [ -f ~/dotfiles/zsh/local.zsh ];then
    source ~/dotfiles/zsh/local.zsh
fi
# エイリアス設定ファイル
if [ -f ~/dotfiles/zsh/alias.zsh ];then
    source ~/dotfiles/zsh/alias.zsh
fi
# プロンプト設定ファイル
if [ -f ~/dotfiles/zsh/prompt.zsh ];then
    source ~/dotfiles/zsh/prompt.zsh
fi
# 環境変数設定ファイル
if [ -f ~/dotfiles/zsh/profile.zsh ];then
    source ~/dotfiles/zsh/profile.zsh
fi

POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
