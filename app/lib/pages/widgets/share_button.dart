import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

export 'package:share_plus/share_plus.dart' show XFile;

class ShareButton extends StatelessWidget {
  const ShareButton({
    this.icon = const Icon(Icons.share),
    super.key,
    this.getFiles,
    this.tooltip,
    this.onShareCompleted,
    this.text,
    this.url,
  });

  final Widget icon;
  final String? tooltip;
  final List<XFile>? Function()? getFiles;
  final VoidCallback? onShareCompleted;
  final String? text;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _handleShare(context),
      icon: icon,
      tooltip: tooltip,
    );
  }

  Future<void> _handleShare(BuildContext context) async {
    final files = getFiles?.call();

    await SharePlus.instance.share(
      ShareParams(
        files: files,
        text: text,
        subject: text,
        uri: url != null ? Uri.parse(url!) : null,
        sharePositionOrigin: !kIsWeb && Platform.isIOS
            ? _getShareButtonRect(context)
            : null,
      ),
    );

    if (context.mounted) {
      onShareCompleted?.call();
    }
  }

  Rect? _getShareButtonRect(BuildContext context) {
    try {
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
    } on Exception catch (error) {
      debugPrint('Failed to get share button rect: $error');
      return null;
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('tooltip', tooltip));
    properties.add(
      ObjectFlagProperty<List<XFile>? Function()?>.has('getFiles', getFiles),
    );
    properties.add(
      ObjectFlagProperty<VoidCallback?>.has(
        'onShareCompleted',
        onShareCompleted,
      ),
    );
    properties.add(StringProperty('text', text));
    properties.add(StringProperty('url', url));
  }
}
