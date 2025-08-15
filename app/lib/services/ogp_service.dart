// OGP (Open Graph Protocol) management service
import 'dart:async';

import 'package:cores/cores.dart';
import 'package:flutter/foundation.dart';
import 'package:web/web.dart' as web;

/// OGP管理を行うサービスのインターフェース
abstract class OgpService {
  /// 現在の実行環境がWebプラットフォームかどうかを取得します
  bool get isWeb;

  /// 基本OGPメタタグを設定します
  void setBasicOgp({
    required String title,
    required String description,
    String? url,
    String? imageUrl,
  });

  /// 楽曲詳細ページのOGPを設定します
  void setMusicOgp(Music music, {String? eventName});

  /// イベント詳細ページのOGPを設定します
  void setEventOgp(Event event);

  /// セットリストページのOGPを設定します
  void setSetlistOgp(Event event, String stageName);

  /// 動的OGP画像を生成します（将来的な拡張用）
  Future<String?> generateOgpImage({
    required String title,
    required String subtitle,
    String? backgroundImageUrl,
  });

  /// 楽曲用OGP画像を生成します（将来的な拡張用）
  Future<String?> generateMusicOgpImage(
    Music music, {
    String? eventName,
  });

  /// イベント用OGP画像を生成します（将来的な拡張用）
  Future<String?> generateEventOgpImage(Event event);

  /// セットリスト用OGP画像を生成します（将来的な拡張用）
  Future<String?> generateSetlistOgpImage(
    Event event,
    String stageName,
  );

  /// 現在のOGP情報をクリアします
  void clearOgp();
}

/// OGP service implementation
class OgpServiceImpl implements OgpService {
  factory OgpServiceImpl() => _instance ??= OgpServiceImpl._();
  OgpServiceImpl._();

  static OgpServiceImpl? _instance;

  @override
  bool get isWeb => kIsWeb;

  @override
  void setBasicOgp({
    required String title,
    required String description,
    String? url,
    String? imageUrl,
  }) {
    if (!kIsWeb) {
      return;
    }

    _updateMetaTag('og:title', title);
    _updateMetaTag('og:description', description);
    _updateMetaTag('twitter:title', title);
    _updateMetaTag('twitter:description', description);

    if (url != null) {
      _updateMetaTag('og:url', url);
    }

    if (imageUrl != null) {
      _updateMetaTag('og:image', imageUrl);
      _updateMetaTag('twitter:image', imageUrl);
    }

    // ページタイトルも更新
    web.document.title = title;
  }

  @override
  void setMusicOgp(Music music, {String? eventName}) {
    if (!kIsWeb) {
      return;
    }

    final title = eventName != null
        ? '${music.title} - $eventName | XINXIN SETLIST'
        : '${music.title} | XINXIN SETLIST';

    final description = '楽曲ID: ${music.id} - XINXIN SETLISTで詳細を確認';

    setBasicOgp(
      title: title,
      description: description,
      url: web.window.location.href,
    );

    // 楽曲専用の動的画像生成
    unawaited(
      generateMusicOgpImage(music, eventName: eventName).then((imageUrl) {
        if (imageUrl != null) {
          _updateMetaTag('og:image', imageUrl);
          _updateMetaTag('twitter:image', imageUrl);
        }
      }),
    );
  }

  @override
  void setEventOgp(Event event) {
    if (!kIsWeb) {
      return;
    }

    final title = '${event.title} | XINXIN SETLIST';
    final description = 'イベントID: ${event.id} / 開催日: ${event.date}';

    setBasicOgp(
      title: title,
      description: description,
      url: web.window.location.href,
    );
  }

  @override
  void setSetlistOgp(Event event, String stageName) {
    if (!kIsWeb) {
      return;
    }

    final title = '$stageName - ${event.title} | XINXIN SETLIST';
    final description = '${event.title}のセットリスト情報';

    setBasicOgp(
      title: title,
      description: description,
      url: web.window.location.href,
    );
  }

  @override
  Future<String?> generateOgpImage({
    required String title,
    required String subtitle,
    String? backgroundImageUrl,
  }) async {
    if (!kIsWeb) {
      return null;
    }

    try {
      // SVGベースの画像生成を使用（Canvas互換性問題を回避）
      final svgContent = _generateSvgOgpImage(title, subtitle);

      // SVGをBase64エンコード
      final svgBase64 = _encodeSvgToBase64(svgContent);
      return 'data:image/svg+xml;base64,$svgBase64';
    } on Exception catch (e) {
      debugPrint('OGP画像生成エラー: $e');
      return null;
    }
  }

  @override
  Future<String?> generateMusicOgpImage(
    Music music, {
    String? eventName,
  }) {
    final title = music.title;
    final subtitle = eventName != null
        ? '$eventName\n楽曲ID: ${music.id}'
        : '楽曲ID: ${music.id}\nXINXIN SETLIST';

    return generateOgpImage(
      title: title,
      subtitle: subtitle,
    );
  }

  @override
  Future<String?> generateEventOgpImage(Event event) {
    return generateOgpImage(
      title: event.title,
      subtitle: 'イベントID: ${event.id}\n開催日: ${event.date}',
    );
  }

  @override
  Future<String?> generateSetlistOgpImage(
    Event event,
    String stageName,
  ) {
    return generateOgpImage(
      title: stageName,
      subtitle: '${event.title}\n${event.date}',
    );
  }

  @override
  void clearOgp() {
    if (!kIsWeb) {
      return;
    }

    // デフォルト値に戻す
    setBasicOgp(
      title: 'XINXIN SETLIST',
      description: 'XINXIN SETLISTで楽曲とセットリスト情報を確認できます',
    );
  }

  void _updateMetaTag(String property, String content) {
    if (!kIsWeb) {
      return;
    }

    // property属性を持つメタタグを検索
    var metaTag = web.document.querySelector('meta[property="$property"]');

    // name属性を持つメタタグも検索（Twitter Cardなど）
    metaTag ??= web.document.querySelector('meta[name="$property"]');

    if (metaTag != null) {
      metaTag.setAttribute('content', content);
    } else {
      // メタタグが存在しない場合は新規作成
      final newMetaTag = web.HTMLMetaElement();
      if (property.startsWith('twitter:')) {
        newMetaTag.name = property;
      } else {
        newMetaTag.setAttribute('property', property);
      }
      newMetaTag.content = content;
      web.document.head?.append(newMetaTag);
    }
  }

  /// SVGを使用してOGP画像を生成する
  String _generateSvgOgpImage(String title, String subtitle) {
    // HTMLエスケープ
    final escapedTitle = _escapeHtml(title);
    final escapedSubtitle = _escapeHtml(subtitle);

    return '''
<svg width="1200" height="630" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="bgGradient" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" style="stop-color:#1a1a2e;stop-opacity:1" />
      <stop offset="50%" style="stop-color:#16213e;stop-opacity:1" />
      <stop offset="100%" style="stop-color:#0f3460;stop-opacity:1" />
    </linearGradient>
  </defs>
  
  <!-- 背景グラデーション -->
  <rect width="1200" height="630" fill="url(#bgGradient)" />
  
  <!-- アクセントライン -->
  <rect x="60" y="80" width="320" height="6" fill="#ff6b6b" />
  
  <!-- XINXIN SETLISTロゴ -->
  <text x="60" y="130" font-family="system-ui, -apple-system, sans-serif" 
        font-size="32" font-weight="bold" fill="white">XINXIN SETLIST</text>
  
  <!-- メインタイトル -->
  <text x="60" y="220" font-family="system-ui, -apple-system, sans-serif" 
        font-size="56" font-weight="bold" fill="white">$escapedTitle</text>
  
  <!-- サブタイトル -->
  ${subtitle.isNotEmpty ? '''
  <text x="60" y="320" font-family="system-ui, -apple-system, sans-serif" 
        font-size="36" fill="#e0e0e0">$escapedSubtitle</text>
  ''' : ''}
  
  <!-- 装飾円 -->
  <circle cx="1000" cy="150" r="80" fill="rgba(255,107,107,0.1)" />
  <circle cx="1100" cy="500" r="60" fill="rgba(255,107,107,0.15)" />
  
  <!-- フッター -->
  <text x="60" y="580" font-family="system-ui, -apple-system, sans-serif" 
        font-size="24" fill="rgba(255,255,255,0.7)">xinxin-setlist.app</text>
</svg>''';
  }

  /// HTMLエスケープを行う
  String _escapeHtml(String text) {
    return text
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#39;');
  }

  /// SVGをBase64エンコードする
  String _encodeSvgToBase64(String svgContent) {
    // UTF-8バイトに変換してBase64エンコード
    final bytes = svgContent.codeUnits;
    final base64String = StringBuffer();

    // 簡易Base64エンコード実装
    const chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

    for (var i = 0; i < bytes.length; i += 3) {
      final b1 = bytes[i];
      final b2 = i + 1 < bytes.length ? bytes[i + 1] : 0;
      final b3 = i + 2 < bytes.length ? bytes[i + 2] : 0;

      final bitmap = (b1 << 16) | (b2 << 8) | b3;

      base64String.write(chars[(bitmap >> 18) & 63]);
      base64String.write(chars[(bitmap >> 12) & 63]);
      base64String.write(
        i + 1 < bytes.length ? chars[(bitmap >> 6) & 63] : '=',
      );
      base64String.write(i + 2 < bytes.length ? chars[bitmap & 63] : '=');
    }

    return base64String.toString();
  }
}
