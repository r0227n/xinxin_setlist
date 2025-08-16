import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

export 'package:share_plus/share_plus.dart' show XFile;

class ShareButton extends StatelessWidget {
  const ShareButton({
    super.key,
    Widget icon = const Icon(Icons.share),
    List<XFile>? Function()? getFiles,
    String? tooltip,
    VoidCallback? onShareCompleted,
    String? text,
    String? subject,
    String? url,
  }) : _icon = icon,
       _getFiles = getFiles,
       _tooltip = tooltip,
       _onShareCompleted = onShareCompleted,
       _text = text,
       _subject = subject,
       _url = url;

  /// 共有ボタンに表示するアイコンウィジェット
  final Widget _icon;

  /// ボタンのツールチップテキスト
  final String? _tooltip;

  /// 共有するファイルを取得する関数
  final List<XFile>? Function()? _getFiles;

  /// 共有完了時に呼び出されるコールバック関数
  final VoidCallback? _onShareCompleted;

  /// 共有するテキスト内容
  final String? _text;

  /// 共有時の件名
  final String? _subject;

  /// 共有するURL
  final String? _url;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _handleShare(context),
      icon: _icon,
      tooltip: _tooltip,
    );
  }

  Future<void> _handleShare(BuildContext context) async {
    final files = _getFiles?.call();

    await SharePlus.instance.share(
      ShareParams(
        files: files,
        text: _text,
        subject: _subject,
        uri: _url != null ? Uri.parse(_url) : null,
        sharePositionOrigin: !kIsWeb && Platform.isIOS
            ? _getShareButtonRect(context)
            : null,
      ),
    );

    if (context.mounted) {
      _onShareCompleted?.call();
    }
  }

  Rect? _getShareButtonRect(BuildContext context) {
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) {
      return null;
    }

    final size = renderBox.size;
    final position = renderBox.localToGlobal(Offset.zero);

    return Rect.fromCenter(
      center: position + Offset(size.width / 2, size.height / 2),
      width: size.width,
      height: size.height,
    );
  }
}
