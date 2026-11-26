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
| `zsh/.zprofile` | ログインシェル。Homebrew の PATH（`brew shellenv`） |
| `zsh/gen-completions.zsh` | mise 管理ツールの zsh 補完を生成 |
| `zsh/abbreviations` | [zsh-abbr](https://zsh-abbr.olets.dev) の略語（`g` → `git` など、スペースで展開） |
| `config/sheldon/plugins.toml` | zsh プラグイン（completions / fzf-tab / autosuggestions / fast-syntax-highlighting） |
| `config/starship.toml` | プロンプト |
| `config/atuin/config.toml` | 履歴検索（Ctrl-R）。同期なし |
| `config/mise/config.toml` | CLI ツールと言語ランタイム（mise で管理） |
| `claude/settings.json` | Claude Code のユーザー設定（`~/.claude/settings.json`） |
| `claude/CLAUDE.md` | Claude Code のグローバル指示（`~/.claude/CLAUDE.md`） |
| `claude/skills/<名前>/SKILL.md` | Claude Code のグローバル skill。`~/.claude/skills/<名前>` にリンクされる |
| `ghostty/config` | Ghostty（`~/Library/Application Support/com.mitchellh.ghostty/config`） |
| `vscode/{settings,keybindings}.json` | VSCode のユーザー設定（VSCode 未インストールならスキップ） |
| `Brewfile` | mise 自体・git・フォント・GUI アプリ・App Store アプリ・VSCode 拡張など mise で入れられないもの |
| `~/.claude/settings.local.json` | マシン固有の Claude Code 設定（リポジトリ管理外） |
| `~/.zshrc.local` | マシン固有の設定（リポジトリ管理外） |

## よく使う操作

- `Ctrl-R`: 履歴検索（atuin） / `Ctrl-T`: ファイル検索 / `Alt-C`: ディレクトリ移動（fzf）
- `z <名前の一部>`: よく行くディレクトリへ移動（zoxide）
- `mise use -g node@lts`: ツール / ランタイムの追加（`config/mise/config.toml` に追記される）
- `mise upgrade`: mise 管理のツールを更新（ツールを追加・更新したら `zsh ~/dotfiles/zsh/gen-completions.zsh` で補完を再生成）
- `sheldon lock --update`: プラグイン更新
- skill の追加: `~/dotfiles/claude/skills/<名前>/SKILL.md` を作って `./setup.sh --no-brew`（`~/.claude/skills` に直接作ったものは管理されないので、`mv` で dotfiles に移してから setup を流す）
