// Web title service for browser tab management
// ignore_for_file: do_not_use_environment

import 'package:flutter/foundation.dart';
import 'package:web/web.dart';

// Web title service interface
/// ブラウザのタブタイトル管理を行うサービスのインターフェース
///
/// このサービスは、Webアプリケーションのページタイトルとブラウザタブタイトルを
/// 統合的に管理し、通知カウント表示やページ階層管理機能を提供します。
abstract class WebTitleService {
  /// 現在の実行環境がWebプラットフォームかどうかを取得します
  bool get isWeb;

  /// 設定されているアプリケーション名を取得します
  String get appName;

  /// 現在のページタイトルを取得します
  String get currentPageTitle;

  /// 現在の通知カウント数を取得します
  int get notificationCount;

  /// タイトルフォーマット文字列を取得します
  ///
  /// デフォルトは '{pageTitle} - {appName}' 形式です。
  /// {count} プレースホルダーを使用して通知カウントも表示できます。
  String get titleFormat;

  /// アプリケーション名を設定します
  ///
  /// [appName] 設定するアプリケーション名
  void setAppName(String appName);

  /// タイトルフォーマットを設定します
  ///
  /// [format] タイトルフォーマット文字列。使用可能なプレースホルダー:
  /// - {pageTitle}: 現在のページタイトル
  /// - {appName}: アプリケーション名
  /// - {count}: 通知カウント（0より大きい場合のみ表示）
  void setTitleFormat(String format);

  /// 現在のページタイトルを更新します
  ///
  /// この操作により、ブラウザタブのタイトルも自動的に更新されます。
  ///
  /// [pageTitle] 新しいページタイトル
  void updatePageTitle(String pageTitle);

  /// 新しいページタイトルをスタックにプッシュします
  ///
  /// 現在のページタイトルが設定されている場合、それを内部スタックに保存してから
  /// 新しいタイトルに更新します。これにより、ページ階層を管理できます。
  ///
  /// [pageTitle] プッシュする新しいページタイトル
  void pushPageTitle(String pageTitle);

  /// スタックから前のページタイトルをポップします
  ///
  /// 内部スタックに保存されているタイトルがある場合、最後に保存されたタイトルを
  /// 復元します。スタックが空の場合は、アプリケーション名にリセットします。
  void popPageTitle();

  /// 通知カウントを設定します
  ///
  /// 設定された値が0より大きい場合、タイトルに通知カウントが表示されます。
  ///
  /// [count] 設定する通知カウント数
  void setNotificationCount(int count);

  /// 通知カウントを1増加させます
  ///
  /// 現在の通知カウントに1を加算し、ブラウザタブタイトルを更新します。
  void incrementNotificationCount();

  /// 通知カウントを0にリセットします
  ///
  /// 通知カウントを0にクリアし、ブラウザタブタイトルから通知表示を削除します。
  void resetNotificationCount();

  /// ブラウザタイトルを直接設定します
  ///
  /// フォーマット処理を行わずに、ブラウザタイトルを直接指定した値に設定します。
  /// Webプラットフォーム以外では何も実行されません。
  ///
  /// [title] 設定するタイトル文字列
  void setCustomTitle(String title);

  /// 現在のブラウザタブタイトルを取得します
  ///
  /// Webプラットフォームの場合は実際のブラウザタイトルを、
  /// それ以外の場合はnullを返します。
  ///
  /// Returns: 現在のブラウザタイトル、またはnull
  String? getCurrentBrowserTitle();

  /// 設定された情報から完全なタイトル文字列を生成します
  ///
  /// タイトルフォーマット、ページタイトル、アプリケーション名、
  /// 通知カウントを組み合わせて、最終的なタイトル文字列を生成します。
  ///
  /// Returns: 生成されたタイトル文字列
  String generateTitle();

  /// タイトルをアプリケーション名にリセットします
  ///
  /// ページタイトルと通知カウントをクリアし、ブラウザタブタイトルを
  /// アプリケーション名のみの表示に戻します。
  void resetToAppName();

  /// 全ての設定をクリアします
  ///
  /// アプリケーション名、ページタイトル、通知カウント、タイトルフォーマット、
  /// 内部スタックを全てクリアし、初期状態に戻します。
  void clear();
}

/// Web title service implementation that manages browser tab titles
class WebTitleServiceImpl implements WebTitleService {
  factory WebTitleServiceImpl() => _instance ??= WebTitleServiceImpl._();
  WebTitleServiceImpl._();

  static WebTitleServiceImpl? _instance;
  var _appName = '';
  var _currentPageTitle = '';
  var _notificationCount = 0;
  var _titleFormat = '{pageTitle} - {appName}';
  final List<String> _titleStack = [];

  @override
  bool get isWeb => kIsWeb;

  @override
  void setAppName(String appName) {
    _appName = appName;
    _updateBrowserTitle();
  }

  @override
  void setTitleFormat(String format) {
    _titleFormat = format;
    _updateBrowserTitle();
  }

  @override
  void updatePageTitle(String pageTitle) {
    _currentPageTitle = pageTitle;
    _updateBrowserTitle();
  }

  @override
  void pushPageTitle(String pageTitle) {
    if (_currentPageTitle.isNotEmpty) {
      _titleStack.add(_currentPageTitle);
    }
    updatePageTitle(pageTitle);
  }

  @override
  void popPageTitle() {
    if (_titleStack.isNotEmpty) {
      final previousTitle = _titleStack.removeLast();
      updatePageTitle(previousTitle);
    } else {
      resetToAppName();
    }
  }

  @override
  void setNotificationCount(int count) {
    _notificationCount = count;
    _updateBrowserTitle();
  }

  @override
  void incrementNotificationCount() {
    _notificationCount++;
    _updateBrowserTitle();
  }

  @override
  void resetNotificationCount() {
    _notificationCount = 0;
    _updateBrowserTitle();
  }

  @override
  void setCustomTitle(String title) {
    if (kIsWeb) {
      document.title = title;
    }
  }

  @override
  String? getCurrentBrowserTitle() {
    if (kIsWeb) {
      return document.title;
    }
    return null;
  }

  /// 設定されているアプリケーション名を取得します
  @override
  String get appName => _appName;

  /// 現在のページタイトルを取得します
  @override
  String get currentPageTitle => _currentPageTitle;

  /// 現在の通知カウント数を取得します
  @override
  int get notificationCount => _notificationCount;

  /// タイトルフォーマット文字列を取得します
  @override
  String get titleFormat => _titleFormat;

  @override
  String generateTitle() {
    var title = _titleFormat;
    title = title.replaceAll('{pageTitle}', _currentPageTitle);
    title = title.replaceAll('{appName}', _appName);

    if (_notificationCount > 0) {
      title = title.replaceAll('{count}', '($_notificationCount) ');
      if (!_titleFormat.contains('{count}')) {
        title = '($_notificationCount) $title';
      }
    } else {
      title = title.replaceAll('{count}', '');
    }

    return _cleanupTitle(title);
  }

  @override
  void resetToAppName() {
    _currentPageTitle = '';
    _notificationCount = 0;
    if (kIsWeb) {
      document.title = _appName.isNotEmpty
          ? _appName
          : const String.fromEnvironment('APP_NAME');
    }
  }

  @override
  void clear() {
    _appName = '';
    _currentPageTitle = '';
    _notificationCount = 0;
    _titleFormat = '{pageTitle} - {appName}';
    _titleStack.clear();
    if (kIsWeb) {
      document.title = _appName.isNotEmpty
          ? _appName
          : const String.fromEnvironment('APP_NAME');
    }
  }

  void _updateBrowserTitle() {
    if (kIsWeb) {
      document.title = generateTitle();
    }
  }

  String _cleanupTitle(String title) {
    return title
        .replaceAll(RegExp(r'\s+'), ' ')
        .replaceAll(RegExp(r'\s*-\s*-\s*'), ' - ')
        .replaceAll(RegExp(r'^-\s*'), '')
        .replaceAll(RegExp(r'\s*-\s*$'), '')
        .trim();
  }
}
