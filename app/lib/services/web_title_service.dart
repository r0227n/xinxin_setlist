// Using String.fromEnvironment for app name fallback
// ignore_for_file: do_not_use_environment

import 'package:flutter/foundation.dart';
import 'package:web/web.dart';

class WebTitleService {
  WebTitleService._();
  static WebTitleService? _instance;
  // Singleton pattern requires static getter method
  // ignore: prefer_constructors_over_static_methods
  static WebTitleService get instance => _instance ??= WebTitleService._();

  var _appName = '';
  var _currentPageTitle = '';
  var _notificationCount = 0;
  var _titleFormat = '{pageTitle} - {appName}';
  final List<String> _titleStack = [];

  /// Platform check for Web environment
  bool get isWeb => kIsWeb;

  /// Configure application name
  void setAppName(String appName) {
    _appName = appName;
    _updateBrowserTitle();
  }

  /// Configure title format template
  /// Available placeholders: {pageTitle}, {appName}, {count}
  /// Example: '{count}{pageTitle} - {appName}' → '(5) Dashboard - My App'
  void setTitleFormat(String format) {
    _titleFormat = format;
    _updateBrowserTitle();
  }

  /// Update current page title
  void updatePageTitle(String pageTitle) {
    _currentPageTitle = pageTitle;
    _updateBrowserTitle();
  }

  /// Push current title to stack and set new title
  void pushPageTitle(String pageTitle) {
    if (_currentPageTitle.isNotEmpty) {
      _titleStack.add(_currentPageTitle);
    }
    updatePageTitle(pageTitle);
  }

  /// Pop previous title from stack and restore
  void popPageTitle() {
    if (_titleStack.isNotEmpty) {
      final previousTitle = _titleStack.removeLast();
      updatePageTitle(previousTitle);
    } else {
      resetToAppName();
    }
  }

  /// Set notification count (unread messages, etc.)
  void setNotificationCount(int count) {
    _notificationCount = count;
    _updateBrowserTitle();
  }

  /// Increment notification count
  void incrementNotificationCount() {
    _notificationCount++;
    _updateBrowserTitle();
  }

  /// Reset notification count to zero
  void resetNotificationCount() {
    _notificationCount = 0;
    _updateBrowserTitle();
  }

  /// Set custom title directly (bypasses formatting)
  void setCustomTitle(String title) {
    if (!isWeb) {
      return;
    }
    document.title = title;
  }

  /// Get current browser title
  String? getCurrentBrowserTitle() {
    if (!isWeb) {
      return null;
    }
    return document.title;
  }

  /// Getters for current state
  String get appName => _appName;
  String get currentPageTitle => _currentPageTitle;
  int get notificationCount => _notificationCount;
  String get titleFormat => _titleFormat;

  /// Generate title based on current format (without setting)
  String generateTitle() {
    var title = _titleFormat;

    // Replace placeholders with actual values
    title = title.replaceAll('{pageTitle}', _currentPageTitle);
    title = title.replaceAll('{appName}', _appName);

    if (_notificationCount > 0) {
      title = title.replaceAll('{count}', '($_notificationCount) ');
      // If no count placeholder, prepend to title
      if (!_titleFormat.contains('{count}')) {
        title = '($_notificationCount) $title';
      }
    } else {
      title = title.replaceAll('{count}', '');
    }

    return _cleanupTitle(title);
  }

  /// Reset to app name only
  void resetToAppName() {
    _currentPageTitle = '';
    _notificationCount = 0;
    if (!isWeb) {
      return;
    }
    document.title = _appName.isNotEmpty
        ? _appName
        : const String.fromEnvironment('APP_NAME');
  }

  /// Clear all settings
  void clear() {
    _appName = '';
    _currentPageTitle = '';
    _notificationCount = 0;
    _titleFormat = '{pageTitle} - {appName}';
    _titleStack.clear();
    if (isWeb) {
      document.title = _appName.isNotEmpty
          ? _appName
          : const String.fromEnvironment('APP_NAME');
    }
  }

  /// Internal: Update browser title
  void _updateBrowserTitle() {
    if (!isWeb) {
      return;
    }
    document.title = generateTitle();
  }

  /// Internal: Clean up title formatting
  String _cleanupTitle(String title) {
    return title
        .replaceAll(RegExp(r'\s+'), ' ') // Multiple spaces to single
        .replaceAll(RegExp(r'\s*-\s*-\s*'), ' - ') // Clean up double hyphens
        .replaceAll(RegExp(r'^-\s*'), '') // Remove leading hyphen
        .replaceAll(RegExp(r'\s*-\s*$'), '') // Remove trailing hyphen
        .trim();
  }
}
