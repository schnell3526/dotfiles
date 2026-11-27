# Ghostty 設定

Ghosttyターミナルエミュレータの設定ファイルです。

## 設定内容

### テーマ設定
- OS の外観に合わせて切り替え（ライト: Catppuccin Latte / ダーク: Catppuccin Macchiato）

### フォント設定
- **フォントファミリー**: HackGen Console NF
- **フォントサイズ**: 16pt
- **フォント機能**: 合字（ligature）を無効化
  - `-calt`: 文脈的代替を無効
  - `-dlig`: 任意の合字を無効
  - `-liga`: 標準的な合字を無効
- **フォント太字化**: 有効（視認性向上）
- **セル高さ調整**: +2（行間を広げて読みやすく）

### ウィンドウ設定
- **タイトルバー**: 透明スタイル（macOS）
- **ウィンドウシャドウ**: 無効（よりクリーンな見た目）
- **パディング**: バランス調整あり、X/Y共に0
- **背景**: 半透明（不透明度85%）+ ブラー効果（半径20px）
- **ウィンドウテーマ**: ghostty

### カーソル設定
- **カーソルスタイル**: ブロック型
- **カーソル点滅**: 無効（集中力向上）

### 遊び・便利機能
- **Quick Terminal**: `cmd+\`` でどのアプリからでも画面上部に開閉（アクセシビリティ権限が必要。位置の変更は Ghostty の再起動が必要）
- **カーソルの残像**: `shaders/cursor_trail.glsl`（重い・不要なら `custom-shader` の行を消す）
- **背景画像**: 星空（`images/stars.png`）
- **アプリアイコン**: holographic
- **非アクティブな分割ペイン**: 暗く表示

### 設定なしで使える機能
- `cmd+↑` / `cmd+↓`: 前後のプロンプトへ移動（シェル統合が必要）
- `cmd+shift+enter`: 今の分割ペインをズーム
- `/Applications/Ghostty.app/Contents/MacOS/ghostty +boo`: おまけのアニメーション

### その他設定
- **タイピング中マウス非表示**: 有効

### ターミナル設定
- **TERM環境変数**: xterm-256color

## ファイル構成

```
ghostty/
├── config          # Ghostty設定ファイル
├── images/         # 背景画像
├── shaders/        # カスタムシェーダー
└── README.md       # このファイル
```

## 使用方法

リポジトリのルートで `setup.sh` を実行してください。

```bash
./setup.sh
```

`~/Library/Application Support/com.mitchellh.ghostty/` に `config`、`shaders`、`images` がシンボリックリンクされます。`~/.config/ghostty/config` も置くと二重に読み込まれるので作らないでください。

## 参考資料

- [Ghostty公式設定ドキュメント](https://ghostty.org/docs/config) - 全ての設定項目の詳細な説明