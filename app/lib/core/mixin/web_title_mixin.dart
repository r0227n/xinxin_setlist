import 'package:app/services/web_title_service.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

mixin WebTitleMixin<T extends StatefulWidget> on State<T> {
  String get pageTitle;

  WebTitleService get _titleService => WebTitleServiceImpl();

  @override
  void initState() {
    super.initState();
    _pushAndUpdateTitle();
  }

  @override
  void dispose() {
    // ページが破棄される時（popback時）に前のタイトルを復元
    _titleService.popPageTitle();
    super.dispose();
  }

  void _pushAndUpdateTitle() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _titleService.pushPageTitle(pageTitle);
    });
  }

  /// Dynamically update page title
  void updatePageTitle(String newTitle) {
    _titleService.updatePageTitle(newTitle);
  }

  /// Set notification count
  void setNotificationCount(int count) {
    _titleService.setNotificationCount(count);
  }

  /// Increment notification count
  void incrementNotificationCount() {
    _titleService.incrementNotificationCount();
  }

  /// Reset notification count
  void resetNotificationCount() {
    _titleService.resetNotificationCount();
  }

  /// Set custom title
  void setCustomTitle(String title) {
    _titleService.setCustomTitle(title);
  }
}

mixin ConsumerWebTitleMixin<T extends ConsumerStatefulWidget>
    on ConsumerState<T> {
  String get pageTitle;

  WebTitleService get _titleService => WebTitleServiceImpl();

  @override
  void initState() {
    super.initState();
    _pushAndUpdateTitle();
  }

  @override
  void dispose() {
    // ページが破棄される時（popback時）に前のタイトルを復元
    _titleService.popPageTitle();
    super.dispose();
  }

  void _pushAndUpdateTitle() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _titleService.pushPageTitle(pageTitle);
    });
  }

  /// Dynamically update page title
  void updatePageTitle(String newTitle) {
    _titleService.updatePageTitle(newTitle);
  }

  /// Set notification count
  void setNotificationCount(int count) {
    _titleService.setNotificationCount(count);
  }

  /// Increment notification count
  void incrementNotificationCount() {
    _titleService.incrementNotificationCount();
  }

  /// Reset notification count
  void resetNotificationCount() {
    _titleService.resetNotificationCount();
  }

  /// Set custom title
  void setCustomTitle(String title) {
    _titleService.setCustomTitle(title);
  }
}
