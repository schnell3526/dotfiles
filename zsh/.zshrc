### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
# zinit light-mode for \
#     zinit-zsh/z-a-rust \
#     zinit-zsh/z-a-as-monitor \
#     zinit-zsh/z-a-patch-dl \
#     zinit-zsh/z-a-bin-gem-node
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
if [ -f ~/dotfiles/zsh/private.zsh ];then
    source ~/dotfiles/zsh/private.zsh
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
