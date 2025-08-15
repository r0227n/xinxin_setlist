import 'package:app/services/ogp_service.dart';
import 'package:app/services/web_title_service.dart';
import 'package:cores/cores.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// WebタイトルとOGPを統合管理するMixin
mixin OgpMixin<T extends StatefulWidget> on State<T> {
  String get pageTitle;

  /// OGP用のタイトル（pageTitle と異なる場合にオーバーライド）
  String get ogpTitle => pageTitle;

  /// OGP用の説明文
  String get ogpDescription;

  /// OGPサービスのインスタンス
  OgpService get _ogpService => OgpServiceImpl();

  @override
  void initState() {
    super.initState();
    _updateOgpAndTitle();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// OGPとページタイトルを更新
  void _updateOgpAndTitle() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _ogpService.setBasicOgp(
        title: ogpTitle,
        description: ogpDescription,
      );
    });
  }

  /// 基本OGP情報を動的に更新
  void updateOgp({
    String? title,
    String? description,
    String? imageUrl,
  }) {
    _ogpService.setBasicOgp(
      title: title ?? ogpTitle,
      description: description ?? ogpDescription,
      imageUrl: imageUrl,
    );
  }

  /// 楽曲専用OGPを設定
  void setMusicOgp(Music music, {String? eventName}) {
    _ogpService.setMusicOgp(music, eventName: eventName);
  }

  /// イベント専用OGPを設定
  void setEventOgp(Event event) {
    _ogpService.setEventOgp(event);
  }

  /// セットリスト専用OGPを設定
  void setSetlistOgp(Event event, String stageName) {
    _ogpService.setSetlistOgp(event, stageName);
  }

  /// OGP画像を動的生成して設定
  Future<void> generateAndSetOgpImage({
    required String title,
    required String subtitle,
  }) async {
    final imageUrl = await _ogpService.generateOgpImage(
      title: title,
      subtitle: subtitle,
    );

    if (imageUrl != null) {
      updateOgp(imageUrl: imageUrl);
    }
  }
}

/// ConsumerStatefulWidget向けのOGP統合Mixin
mixin ConsumerOgpMixin<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  String get pageTitle;

  /// OGP用のタイトル（pageTitle と異なる場合にオーバーライド）
  String get ogpTitle => pageTitle;

  /// OGP用の説明文
  String get ogpDescription;

  /// OGPサービスのインスタンス
  OgpService get _ogpService => OgpServiceImpl();

  @override
  void initState() {
    super.initState();
    _updateOgpAndTitle();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// OGPとページタイトルを更新
  void _updateOgpAndTitle() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _ogpService.setBasicOgp(
        title: ogpTitle,
        description: ogpDescription,
      );
    });
  }

  /// 基本OGP情報を動的に更新
  void updateOgp({
    String? title,
    String? description,
    String? imageUrl,
  }) {
    _ogpService.setBasicOgp(
      title: title ?? ogpTitle,
      description: description ?? ogpDescription,
      imageUrl: imageUrl,
    );
  }

  /// 楽曲専用OGPを設定
  void setMusicOgp(Music music, {String? eventName}) {
    _ogpService.setMusicOgp(music, eventName: eventName);
  }

  /// イベント専用OGPを設定
  void setEventOgp(Event event) {
    _ogpService.setEventOgp(event);
  }

  /// セットリスト専用OGPを設定
  void setSetlistOgp(Event event, String stageName) {
    _ogpService.setSetlistOgp(event, stageName);
  }

  /// OGP画像を動的生成して設定
  Future<void> generateAndSetOgpImage({
    required String title,
    required String subtitle,
  }) async {
    final imageUrl = await _ogpService.generateOgpImage(
      title: title,
      subtitle: subtitle,
    );

    if (imageUrl != null) {
      updateOgp(imageUrl: imageUrl);
    }
  }
}

/// WebTitleMixinとOGPを統合したMixin
mixin WebTitleOgpMixin<T extends StatefulWidget> on State<T>
    implements OgpMixin<T> {
  @override
  String get pageTitle;

  @override
  String get ogpTitle => pageTitle;

  @override
  String get ogpDescription;

  /// WebTitleServiceのインスタンス
  WebTitleService get _titleService => WebTitleServiceImpl();

  @override
  OgpService get _ogpService => OgpServiceImpl();

  @override
  void initState() {
    super.initState();
    _pushAndUpdateTitleWithOgp();
  }

  @override
  void dispose() {
    // ページが破棄される時（popback時）に前のタイトルを復元
    _titleService.popPageTitle();
    super.dispose();
  }

  void _pushAndUpdateTitleWithOgp() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // WebTitleServiceでページタイトルを管理
      _titleService.pushPageTitle(pageTitle);

      // OGP情報も同時に設定
      _ogpService.setBasicOgp(
        title: ogpTitle,
        description: ogpDescription,
      );
    });
  }

  /// ページタイトルとOGPを動的に更新
  void updatePageTitleAndOgp(String newTitle, {String? newDescription}) {
    _titleService.updatePageTitle(newTitle);
    _ogpService.setBasicOgp(
      title: newTitle,
      description: newDescription ?? ogpDescription,
    );
  }

  /// 通知カウントを設定
  void setNotificationCount(int count) {
    _titleService.setNotificationCount(count);
  }

  /// 通知カウントを増加
  void incrementNotificationCount() {
    _titleService.incrementNotificationCount();
  }

  /// 通知カウントをリセット
  void resetNotificationCount() {
    _titleService.resetNotificationCount();
  }

  /// カスタムタイトルを設定
  void setCustomTitle(String title) {
    _titleService.setCustomTitle(title);
  }
}

/// ConsumerStatefulWidget向けのWebTitleとOGP統合Mixin
mixin ConsumerWebTitleOgpMixin<T extends ConsumerStatefulWidget>
    on ConsumerState<T>
    implements ConsumerOgpMixin<T> {
  @override
  String get pageTitle;

  @override
  String get ogpTitle => pageTitle;

  @override
  String get ogpDescription;

  /// WebTitleServiceのインスタンス
  WebTitleService get _titleService => WebTitleServiceImpl();

  @override
  OgpService get _ogpService => OgpServiceImpl();

  @override
  void initState() {
    super.initState();
    _pushAndUpdateTitleWithOgp();
  }

  @override
  void dispose() {
    // ページが破棄される時（popback時）に前のタイトルを復元
    _titleService.popPageTitle();
    super.dispose();
  }

  void _pushAndUpdateTitleWithOgp() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // WebTitleServiceでページタイトルを管理
      _titleService.pushPageTitle(pageTitle);

      // OGP情報も同時に設定
      _ogpService.setBasicOgp(
        title: ogpTitle,
        description: ogpDescription,
      );
    });
  }

  /// ページタイトルとOGPを動的に更新
  void updatePageTitleAndOgp(String newTitle, {String? newDescription}) {
    _titleService.updatePageTitle(newTitle);
    _ogpService.setBasicOgp(
      title: newTitle,
      description: newDescription ?? ogpDescription,
    );
  }

  /// 通知カウントを設定
  void setNotificationCount(int count) {
    _titleService.setNotificationCount(count);
  }

  /// 通知カウントを増加
  void incrementNotificationCount() {
    _titleService.incrementNotificationCount();
  }

  /// 通知カウントをリセット
  void resetNotificationCount() {
    _titleService.resetNotificationCount();
  }

  /// カスタムタイトルを設定
  void setCustomTitle(String title) {
    _titleService.setCustomTitle(title);
  }

  // ConsumerOgpMixin の実装
  @override
  void updateOgp({
    String? title,
    String? description,
    String? imageUrl,
  }) {
    _ogpService.setBasicOgp(
      title: title ?? ogpTitle,
      description: description ?? ogpDescription,
      imageUrl: imageUrl,
    );
  }

  @override
  void setMusicOgp(Music music, {String? eventName}) {
    _ogpService.setMusicOgp(music, eventName: eventName);
  }

  @override
  void setEventOgp(Event event) {
    _ogpService.setEventOgp(event);
  }

  @override
  void setSetlistOgp(Event event, String stageName) {
    _ogpService.setSetlistOgp(event, stageName);
  }

  @override
  Future<void> generateAndSetOgpImage({
    required String title,
    required String subtitle,
  }) async {
    final imageUrl = await _ogpService.generateOgpImage(
      title: title,
      subtitle: subtitle,
    );

    if (imageUrl != null) {
      updateOgp(imageUrl: imageUrl);
    }
  }
}
