# ---------------------------------------------------------------
# 基本設定
# ---------------------------------------------------------------
export LANG=ja_JP.UTF-8
setopt print_eight_bit      # 日本語ファイル名を表示
setopt auto_cd              # ディレクトリ名だけで cd
setopt interactive_comments # 対話シェルでも # コメントを使える
setopt extended_glob        # 拡張 glob（compinit のキャッシュ判定でも使用）

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

# ---------------------------------------------------------------
# プラグイン（~/.config/sheldon/plugins.toml）
#   zsh-completions → compinit → fzf-tab → autosuggestions → syntax-highlighting
# ---------------------------------------------------------------
export ABBR_USER_ABBREVIATIONS_FILE=~/dotfiles/zsh/abbreviations
eval "$(sheldon source)"

# ---------------------------------------------------------------
# ツール
# ---------------------------------------------------------------
eval "$(mise activate zsh)"                 # node / python / go などのバージョン管理
eval "$(zoxide init zsh)"                   # z <dir>
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

# マシン固有の設定（PATH 追加など、リポジトリに入れないもの）
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
