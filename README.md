# dotfiles

zsh + [sheldon](https://sheldon.cli.rs) + [starship](https://starship.rs) + [mise](https://mise.jdx.dev) + [atuin](https://atuin.sh)

## Install (macOS)

```shell
git clone https://github.com/schnell3526/dotfiles ~/dotfiles
~/dotfiles/setup.sh        # シンボリックリンク作成 + brew bundle + sheldon lock
```

既存の `~/.zshrc` などは `*.bak.<日時>` に退避される。ターミナルのフォントは Nerd Font（Brewfile の `font-jetbrains-mono-nerd-font`）を選ぶ。

## 構成

| ファイル | 内容 |
|---|---|
| `zsh/.zshrc` | 本体。履歴・補完設定と各ツールの init |
| `zsh/abbreviations` | [zsh-abbr](https://zsh-abbr.olets.dev) の略語（`g` → `git` など、スペースで展開） |
| `config/sheldon/plugins.toml` | zsh プラグイン（completions / fzf-tab / autosuggestions / fast-syntax-highlighting） |
| `config/starship.toml` | プロンプト |
| `config/atuin/config.toml` | 履歴検索（Ctrl-R）。同期なし |
| `Brewfile` | 必要な CLI |
| `~/.zshrc.local` | マシン固有の設定（リポジトリ管理外） |

## よく使う操作

- `Ctrl-R`: 履歴検索（atuin） / `Ctrl-T`: ファイル検索 / `Alt-C`: ディレクトリ移動（fzf）
- `z <名前の一部>`: よく行くディレクトリへ移動（zoxide）
- `mise use -g node@lts python@3.12`: 言語ランタイムのインストール
- `sheldon lock --update`: プラグイン更新
