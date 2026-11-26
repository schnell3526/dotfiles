# ログインシェル: Homebrew の PATH / HOMEBREW_PREFIX を設定（.zshrc の mise activate より前に必要）
if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi
