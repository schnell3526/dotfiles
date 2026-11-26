#!/usr/bin/env zsh
# mise で入れた CLI の zsh 補完ファイルを生成する
# mise はツールの補完ファイルを fpath に置かないため、各ツールの生成コマンドで作る
# setup.sh から呼ばれる。`mise upgrade` やツール追加の後にも実行する
set -u

dir=${XDG_DATA_HOME:-$HOME/.local/share}/zsh/completions
shims=${MISE_DATA_DIR:-$HOME/.local/share/mise}/shims
mkdir -p "$dir"

gen() {
    local name=$1; shift
    if "$@" >"$dir/_$name.tmp" 2>/dev/null && [[ -s $dir/_$name.tmp ]]; then
        mv "$dir/_$name.tmp" "$dir/_$name"
        print "generated: _$name"
    else
        rm -f "$dir/_$name.tmp"
        print "skipped:   _$name"
    fi
}

gen gh       "$shims/gh" completion -s zsh
gen fd       "$shims/fd" --gen-completions zsh
gen rg       "$shims/rg" --generate complete-zsh
gen bat      "$shims/bat" --completion zsh
gen atuin    "$shims/atuin" gen-completions --shell zsh
gen starship "$shims/starship" completions zsh

# 補完キャッシュを作り直させる
rm -f "${ZDOTDIR:-$HOME}/.zcompdump"
