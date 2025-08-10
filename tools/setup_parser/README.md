# setup_parser

セットリスト情報をパースしてJSONファイルに変換するコマンドラインツール。

## 概要

setup_parserは、テキストファイルから読み込んだイベント・セットリスト情報を解析し、アプリで使用するJSONファイル（event.json、stage.json、music.json）を自動生成・更新するツールです。

## 使用方法

### 基本使用法

```bash
dart run setup_parser -f input_file.txt
```

### 複数ファイルの処理

```bash
dart run setup_parser -f file1.txt,file2.txt,file3.txt
```

### ヘルプの表示

```bash
dart run setup_parser -h
```

## 入力ファイルフォーマット

入力テキストファイルは以下の形式で記述してください：

```
#XINXINセトリ
2025.8.7 Thu. 大阪Anima
『IDO-LIVE!! EXTREME』

(SE)To The Deep World
1. サイノメ
2. STARDUST
3. BINARY NUMBER
4. GHOST
5. デスパレードグローリーデイズ
6. 1ミリの勇気
```

### フォーマット仕様

1. **1行目（オプション）**: ヘッダー
   - 形式: `#XINXINセトリ`
   - この行がある場合は自動的にスキップされます

2. **日付と会場行**: 
   - 形式: `YYYY.M.D DDD. 会場名`
   - 例: `2025.8.7 Thu. 大阪Anima`

3. **イベントタイトル**: 
   - 日付・会場行の次から最初の空行まで
   - 複数行に対応
   - JSON出力時は改行がスペースに置換されます
   - 例: 
     ```
     『IDO-LIVE!! EXTREME
     Vol.03』
     ```

4. **セットリスト**: 
   - SE（効果音）: `(SE)楽曲名`
   - 楽曲: `番号. 楽曲名`
   - 空行は無視されます

## 出力

このツールは以下のJSONファイルを自動生成・更新します：

- `../../app/assets/event.json` - イベント情報
- `../../app/assets/stage.json` - 会場情報
- `../../app/assets/music.json` - 楽曲情報

## 機能

- 重複する会場・楽曲の自動検出と再利用
- 一意IDの自動生成
- 日付順でのイベントソート
- JSONファイルの自動フォーマット（prettier使用）
- エラーハンドリングと詳細な例外メッセージ
- ヘッダー行（#XINXINセトリ）の自動スキップ
- 複数行イベントタイトルの対応
- JSON出力時の改行文字のスペース置換

## 依存関係

- Dart SDK ^3.8.1
- args パッケージ
- cores パッケージ（プロジェクト内）
- bun（JSONフォーマット用、オプション）

## サンプル

プロジェクトには `sample_input.txt` ファイルが含まれており、正しいフォーマットの例として使用できます。

```bash
dart run setup_parser -f sample_input.txt
```
