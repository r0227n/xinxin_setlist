# XINXIN SETLIST

XINXIN のライブセットリスト([#XINXINセトリ](https://x.com/hashtag/XINXIN%E3%82%BB%E3%83%88%E3%83%AA?src=hashtag_click))閲覧アプリケーションです。過去のライブイベントのセットリスト情報を楽曲詳細とともに閲覧できます。

https://r0227n.github.io/xinxin_setlist/

## 主な機能

### 📋 セットリスト閲覧

- イベントごとのセットリストをカード形式で表示
- イベント名、開催日、会場情報の一覧表示
- セットリスト内の楽曲をチップ形式で表示

### 🎵 楽曲詳細

- 楽曲の基本情報（タイトル、サムネイル）表示
- YouTube での楽曲再生機能
- その楽曲が使用されたイベント一覧
- SNS 共有機能

### 🏢 会場・イベント情報

- ライブ会場の詳細情報
- 特定イベントのセットリスト詳細表示
- イベント情報の共有機能

### ⚙️ アプリケーション設定

- アプリケーション設定画面
- ライセンス情報表示

## 技術スタック

### フレームワーク・言語

- **Flutter** - クロスプラットフォーム UI フレームワーク
- **Dart** - プログラミング言語

### 状態管理・ナビゲーション

- **Riverpod** - 状態管理（hooks_riverpod, riverpod_annotation）
- **go_router** - 型安全なナビゲーション

### 国際化・UI

- **slang** - 型安全な多言語対応（日本語/英語）
- **Google Fonts** - フォント管理
- **Material Design** - UI デザインシステム

### データ管理

- **JSON** - ローカルアセットデータ（楽曲、会場、イベント情報）
- **SharedPreferences** - アプリケーション設定保存

### 外部サービス連携

- **YouTube Player** - 楽曲再生機能
- **Firebase Analytics** - アクセス解析
- **Share Plus** - SNS 共有機能

### 開発・ビルドツール

- **build_runner** - コード生成
- **freezed** - データクラス生成
- **json_serializable** - JSON シリアライゼーション

## データ構造

### 楽曲 (Music)

- Spotify ID（22文字）
- YouTube 動画 ID
- 楽曲名（日本語）
- サムネイル画像 URL

### 会場 (Stage)

- 会場 ID（22文字）
- 会場名

### イベント (Event)

- イベント ID（22文字）
- 会場 ID（外部キー）
- イベント名
- 開催日
- セットリスト（楽曲 ID と順序の配列）

## アーキテクチャ

### Repository パターン

- **MusicRepository** - 楽曲データの管理
- **StageRepository** - 会場データの管理
- **EventRepository** - イベントデータの管理

### サービス層

- **SetlistService** - セットリスト関連のビジネスロジック
- **FirebaseAnalyticsService** - アナリティクス機能
- **WebTitleService** - Web 版タイトル管理

## セットリスト追加ワークフロー

新しいセットリストデータを追加するためのワークフロー手順：

1. **setlist ディレクトリにテキストファイルを作成し、remote branch に push する**
   - 新しいセットリストの情報を以下のフォーマットでテキストファイル形式で setlist ディレクトリに作成
   - 変更内容を remote branch にプッシュ

   **セットリストファイルフォーマット：**

   ```txt
   <実施日> <曜日> <会場名>
   『<イベント名>』

   (SE)<SE楽曲名>
   1. <楽曲名1>
   2. <楽曲名2>
   3. <楽曲名3>
   ...
   ```

   **フォーマット例：**

   ```txt
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

2. **PR を作成することにより、`setlist-parser.yml` を実行する**
   - プルリクエストの作成をトリガーに GitHub Actions ワークフローが自動実行
   - セットリスト解析処理が開始

3. **パースし、event.json や stage.json を更新する**
   - テキストファイルの内容を解析してデータ形式に変換
   - アプリケーションで利用するイベントデータと会場データを自動更新

4. **変更内容が問題なければ、PR をマージする**
   - 解析結果とデータ更新内容をレビュー
   - 問題がない場合はプルリクエストをメインブランチにマージ

5. **main branch にマージされたら、`deploy-github-pages.yml` を実行し、Page を更新する**
   - メインブランチへのマージをトリガーにデプロイメントワークフローが実行
   - GitHub Pages 上のアプリケーションが最新データで自動更新
