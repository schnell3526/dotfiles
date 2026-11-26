# dotfiles

zsh + [sheldon](https://sheldon.cli.rs) + [starship](https://starship.rs) + [mise](https://mise.jdx.dev) + [atuin](https://atuin.sh)

## Install (macOS)

```shell
git clone https://github.com/schnell3526/dotfiles ~/dotfiles
~/dotfiles/setup.sh        # シンボリックリンク作成 + brew bundle + mise install + sheldon lock
```

既存の `~/.zshrc` などは `*.bak.<日時>` に退避される。ターミナルのフォントは Nerd Font（Brewfile の `font-jetbrains-mono-nerd-font`）を選ぶ。

## 構成

| ファイル | 内容 |
|---|---|
| `zsh/.zshrc` | 本体。履歴・補完設定と各ツールの init |
| `zsh/gen-completions.zsh` | mise 管理ツールの zsh 補完を生成 |
| `zsh/abbreviations` | [zsh-abbr](https://zsh-abbr.olets.dev) の略語（`g` → `git` など、スペースで展開） |
| `config/sheldon/plugins.toml` | zsh プラグイン（completions / fzf-tab / autosuggestions / fast-syntax-highlighting） |
| `config/starship.toml` | プロンプト |
| `config/atuin/config.toml` | 履歴検索（Ctrl-R）。同期なし |
| `config/mise/config.toml` | CLI ツールと言語ランタイム（mise で管理） |
| `Brewfile` | mise 自体・git・フォントなど mise で入れられないもの |
| `~/.zshrc.local` | マシン固有の設定（リポジトリ管理外） |

## よく使う操作

- `Ctrl-R`: 履歴検索（atuin） / `Ctrl-T`: ファイル検索 / `Alt-C`: ディレクトリ移動（fzf）
- `z <名前の一部>`: よく行くディレクトリへ移動（zoxide）
- `mise use -g node@lts`: ツール / ランタイムの追加（`config/mise/config.toml` に追記される）
- `mise upgrade`: mise 管理のツールを更新（ツールを追加・更新したら `zsh ~/dotfiles/zsh/gen-completions.zsh` で補完を再生成）
- `sheldon lock --update`: プラグイン更新
