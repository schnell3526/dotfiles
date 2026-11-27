# ツールのインストール方針

- ツールやランタイム(go, node, terraform, kubectl など)が必要になったら、mise で入れられるものは mise で入れる。`brew install` や公式 tarball の手動展開より mise を優先する。
- 確認は `mise registry | grep <name>` や `mise ls-remote <name>` で行う。
- ユーザー全体で常用するものは `~/dotfiles/config/mise/config.toml` に追加する(`mise use -g`)。
- 調査や検証だけの一時的な利用なら、グローバル設定は変えず、プロジェクトローカルの `mise use` か `mise exec <tool>@<version> -- <cmd>` を使う。
- mise にないものだけ Homebrew(`Brewfile`)を使う。GUI アプリも Homebrew。
- システムやグローバル設定を変える前には、何をどこに入れるかをユーザーに伝える。
