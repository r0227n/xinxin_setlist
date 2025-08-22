# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-08-22

### Added

- **セットリスト管理機能**: XINXIN セットリストアプリケーションの初期実装
- **楽曲詳細画面**: 個別楽曲の詳細情報表示機能
- **YouTube再生機能**: 楽曲のYouTube動画再生機能
- **セットリスト詳細画面**: セットリスト全体の詳細表示
- **共有機能**: セットリスト情報の共有機能（テキスト付き）
- **ダークテーマ対応**: DarkThemeColorsクラスによる本格的なダークモード
- **Google Analytics**: サイトアクセス解析の導入
- **OGP設定**: ソーシャルメディア共有時の情報表示
- **日本語フォント**: Google Fonts日本語フォントによる文字化け対策
- **PWA対応**: プログレッシブウェブアプリ機能
- **ライセンス管理**: Google Fontsライセンス管理機能
- **問合せ機能**: 設定画面での問合せ項目
- **型安全性向上**: ID用独自型定義によるバグ防止

### Technical Improvements

- **Flutter 3.35.1**: フレームワークの最新版へのアップデート
- **GitHub Pages**: 自動デプロイパイプライン構築
- **コードジェネレーション**: データモデルの自動生成機能
- **CI/CD**: GitHub Actionsによる自動テスト・デプロイ
- **Commitlint**: コミットメッセージ品質管理
- **Husky**: Git フック機能の追加

### Fixed

- **SafeArea背景色**: PWA対応での表示問題修正
- **サムネイル表示**: 画像表示エラーの解決
- **楽曲ソート**: musicIds順序によるソート処理漏れ修正
- **UI表示**: 選択中楽曲の視覚的フィードバック改善

### Development Infrastructure

- **Monorepo構成**: Melosによるマルチパッケージ管理
- **JSON データ**: 楽曲、イベント、ステージ情報のデータ化
- **型安全ルーティング**: go_routerによる堅牢なナビゲーション
- **状態管理**: Riverpodによる効率的な状態管理
- **国際化**: slangによる多言語対応基盤

### Project Foundation

- **Core パッケージ**: 共通データモデルとビジネスロジック
- **Repository パターン**: データアクセス層の抽象化
- **コンポーネント設計**: 再利用可能なUIコンポーネント
- **セットリストパーサー**: CLIツールによるデータ変換機能

### Documentation

- **仕様書**: アプリケーション仕様の文書化
- **アーキテクチャ**: 技術構成とパッケージ構造の説明
- **セットアップ**: 開発環境構築ガイド
- **コントリビューション**: 開発参加ガイドライン

### Highlights

このリリースは、XINXIN セットリストアプリケーションの初回公開版です。Flutter/Webベースのプログレッシブウェブアプリとして、楽曲情報の閲覧、YouTube動画再生、セットリスト共有などの主要機能を提供します。モダンなFlutterアーキテクチャ（Riverpod + go_router + slang）を採用し、型安全性と保守性を重視した設計となっています。
