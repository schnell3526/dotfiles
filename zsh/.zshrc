# ---------------------------------------------------------------
# 基本設定
# ---------------------------------------------------------------
export LANG=ja_JP.UTF-8
setopt print_eight_bit      # 日本語ファイル名を表示
setopt auto_cd              # ディレクトリ名だけで cd
setopt interactive_comments # 対話シェルでも # コメントを使える
setopt extended_glob        # 拡張 glob（compinit のキャッシュ判定でも使用）
# emacs キーバインド。fzf / atuin などがキーを登録する前に選ぶ
# （EDITOR=vim だと既定が viins になり、後から切り替えると登録したキーが消える）
bindkey -e

# 履歴（検索は atuin が担当、こちらは zsh 側のファイル）
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt share_history hist_ignore_all_dups hist_reduce_blanks hist_ignore_space

# 補完
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'   # 大文字小文字を区別しない
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':fzf-tab:*' switch-group '<' '>'
[[ -n $HOMEBREW_PREFIX ]] && fpath=("$HOMEBREW_PREFIX/share/zsh/site-functions" $fpath)
# mise 管理ツールの補完（zsh/gen-completions.zsh で生成）
fpath=("${XDG_DATA_HOME:-$HOME/.local/share}/zsh/completions" $fpath)

# ---------------------------------------------------------------
# プラグイン（~/.config/sheldon/plugins.toml）
#   zsh-completions → compinit → fzf-tab → autosuggestions → syntax-highlighting
# ---------------------------------------------------------------
# mise を最初に有効化する（sheldon / starship などの CLI は mise 管理: ~/.config/mise/config.toml）
eval "$(mise activate zsh)"

export ABBR_USER_ABBREVIATIONS_FILE=~/dotfiles/zsh/abbreviations
eval "$(sheldon source)"

# ---------------------------------------------------------------
# ツール
# ---------------------------------------------------------------
eval "$(zoxide init zsh)"                 # z <dir>
source <(fzf --zsh)                         # Ctrl-T: ファイル, Alt-C: cd
eval "$(atuin init zsh --disable-up-arrow)" # Ctrl-R: 履歴検索（↑キーは通常動作）
eval "$(starship init zsh)"                 # プロンプト（~/.config/starship.toml）

# ---------------------------------------------------------------
# エイリアス（展開したいものは zsh/abbreviations へ）
# ---------------------------------------------------------------
alias ls='eza --group-directories-first'
alias ll='eza -l --git --group-directories-first'
alias la='eza -la --git --group-directories-first'
alias lt='eza --tree --level=2'
alias cat='bat --paging=never'
alias rm='rm -i'

mkcd() { mkdir -p "$1" && cd "$1" }
alias k9s='LANG=en_US.UTF-8 k9s'  # k9s の文字化け対策
# git のユーザーを個人アカウントに変更する
alias git-personal='git config user.name "schnell3526" && git config user.email "schnelldickheiter@gmail.com"'
# docker で作ったコマンド（$(pwd) は実行時に評価する）
alias c-cutter='docker run -it -v "$(pwd)":/app --rm docker-cookiecutter'

# git log を幅で切り詰めて表示（abbr の gl で展開）。usage: git_smart_log [幅] [git log の引数...]
git_smart_log() {
    local default_width=120  # デフォルト値を設定
    local width=$default_width
    if [[ $# -gt 0 && "$1" =~ ^[0-9]+$ ]]; then
        width=$1
        shift
    fi
    git log --graph --color=always \
        --format=format:'%C(auto)%h%d %C(green)%ar%Creset by"%C(cyan ul)%an%Creset" %s' \
        "$@" |
    perl -e "
        use Term::ANSIColor qw(colorstrip);
        my \$width = $width;
        while (<>) {
            my \$stripped = colorstrip(\$_);
            if (length(\$stripped) > \$width) {
                my \$visible_len = 0;
                my \$truncated = '';
                while (\$visible_len < \$width - 3) {
                    if (\$_ =~ /\\G(?:\\e\\[[0-9;]*m)*([^\\e]|\\e\\[[0-9;]*m)/gc) {
                        \$truncated .= \$&;
                        \$visible_len++ if \$1 ne '' and \$1 !~ /\\e/;
                    }
                }
                \$_ = \$truncated . \"...\\n\";
            }
            print \$_;
        }
    " |
    less -RFX
}

# マシン固有の設定（PATH 追加など、リポジトリに入れないもの）
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
