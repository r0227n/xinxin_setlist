import 'dart:async';

import 'package:app/core/mixin/web_title_mixin.dart';
import 'package:app/data/repositories/music_repository.dart';
import 'package:app/data/services/setlist_service.dart';
import 'package:app/i18n/translations.g.dart';
import 'package:app/pages/setlist_page.dart';
import 'package:app_logger/app_logger.dart';
import 'package:app_preferences/app_preferences.dart';
import 'package:cores/cores.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

/// 楽曲詳細表示ページ
///
/// [musicId]で指定された楽曲の詳細情報をFutureBuilderで表示し、
/// その楽曲が採用されているセットリスト一覧へのナビゲーションを提供する
class MusicDetailPage extends ConsumerStatefulWidget {
  const MusicDetailPage({
    required this.musicId,
    super.key,
  });

  /// 表示する楽曲のID
  final String musicId;

  @override
  ConsumerState<MusicDetailPage> createState() => _MusicDetailPageState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('musicId', musicId));
  }
}

class _MusicDetailPageState extends ConsumerState<MusicDetailPage>
    with ConsumerWebTitleMixin, LoggerMixin {
  /// 楽曲詳細データの取得Future
  late Future<Music> _musicDetailFuture;

  @override
  String get pageTitle => t.music.detail;

  @override
  void initState() {
    super.initState();
    _musicDetailFuture = _loadMusicDetail();
  }

  @override
  void didUpdateWidget(MusicDetailPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // musicIdが変更された場合は再読み込み
    if (oldWidget.musicId != widget.musicId) {
      _musicDetailFuture = _loadMusicDetail();
    }
  }

  /// 楽曲詳細データを取得する
  Future<Music> _loadMusicDetail() async {
    try {
      final music = await ref
          .read(musicRepositoryProvider.notifier)
          .get(widget.musicId);
      logInfo('楽曲詳細を表示: ${music.toJson()}');
      // ブラウザタブのタイトルを楽曲名に設定
      WidgetsBinding.instance.addPostFrameCallback((_) {
        updatePageTitle(music.title);
      });
      return music;
    } catch (error) {
      logError('楽曲詳細の取得に失敗: $error');
      rethrow;
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('musicId', widget.musicId));
    properties.add(StringProperty('pageTitle', pageTitle));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.music.detail),
      ),
      body: FutureBuilder<Music>(
        future: _musicDetailFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final music = snapshot.data!;
            return LayoutBuilder(
              builder: (context, constraints) {
                final isLargeScreen =
                    constraints.maxWidth > AppLayout.largeScreenBreakpoint;

                if (isLargeScreen) {
                  // 大画面レイアウト: 左側3割にCard、右側7割にSetlist
                  return _DesktopMusicDetailLayout(music);
                } else {
                  // 小画面レイアウト: 現在と同じ縦レイアウト
                  return _MobileMusicDetailLayout(music);
                }
              },
            );
          } else if (snapshot.hasError) {
            return Icon(
              Icons.error,
              size: AppIconSizes.xxl,
              color: Theme.of(context).colorScheme.error,
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

/// デスクトップ用の楽曲詳細レイアウト
class _DesktopMusicDetailLayout extends StatelessWidget {
  const _DesktopMusicDetailLayout(Music music) : _music = music;

  /// 表示する楽曲データ
  final Music _music;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: AppAnimationDurations.normal,
      child: Padding(
        key: ValueKey(_music.id),
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 左側3割: 楽曲情報カード
            Expanded(
              flex: AppLayout.desktopMusicInfoFlex,
              child: _MusicCard(_music),
            ),

            // 右側7割: セットリストページ
            Expanded(
              flex: AppLayout.desktopSetlistFlex,
              child: AnimatedSwitcher(
                duration: AppAnimationDurations.fast,
                child: SetlistPage(
                  key: ValueKey('setlist_${_music.id}'),
                  musicId: _music.id,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// モバイル用の楽曲詳細レイアウト
class _MobileMusicDetailLayout extends StatelessWidget {
  const _MobileMusicDetailLayout(Music music) : _music = music;

  /// 表示する楽曲データ
  final Music _music;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: AppAnimationDurations.normal,
      child: Padding(
        key: ValueKey(_music.id),
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.large,
          children: [
            // 楽曲情報カード
            _MusicCard(_music),

            Expanded(
              child: AnimatedSwitcher(
                duration: AppAnimationDurations.fast,
                child: SetlistPage(
                  key: ValueKey('setlist_${_music.id}'),
                  musicId: _music.id,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 楽曲情報カードを表示するStatelessWidget
class _MusicCard extends StatelessWidget {
  const _MusicCard(Music music) : _music = music;

  /// 表示する楽曲データ
  final Music _music;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppLayout.cardElevation,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.medium,
          children: [
            // サムネイル画像
            _Thumbnail(music: _music),

            // 楽曲タイトル
            Text(
              _music.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            _AdoptionCountBadge(musicId: _music.id),
          ],
        ),
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({required Music music}) : _music = music;

  final Music _music;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppBorderRadius.small),
      child: _music.youtubeId != null
          ? _YouTube(youtubeId: _music.youtubeId!, locale: locale)
          : Image.network(
              _music.thumbnailUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.music_note, size: AppIconSizes.xxl),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),
    );
  }
}

class _YouTube extends StatefulWidget {
  const _YouTube({
    required String youtubeId,
    required Locale locale,
  }) : _youtubeId = youtubeId,
       _locale = locale;

  final String _youtubeId;
  final Locale _locale;

  @override
  State<_YouTube> createState() => __YouTubeState();
}

class __YouTubeState extends State<_YouTube> with LoggerMixin {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final languageCode = widget._locale.languageCode;
    logInfo('load video: ${widget._youtubeId} / languageCode: $languageCode');
    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget._youtubeId,
      params: YoutubePlayerParams(
        captionLanguage: languageCode,
        showFullscreenButton: true,
        interfaceLanguage: languageCode,
      ),
    );
  }

  @override
  void dispose() {
    unawaited(_controller.close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
    );
  }
}

/// 採用回数バッジを表示するStatefulWidget
class _AdoptionCountBadge extends ConsumerStatefulWidget {
  const _AdoptionCountBadge({required this.musicId});

  /// 楽曲ID
  final String musicId;

  @override
  ConsumerState<_AdoptionCountBadge> createState() =>
      _AdoptionCountBadgeState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('musicId', musicId));
  }
}

class _AdoptionCountBadgeState extends ConsumerState<_AdoptionCountBadge> {
  /// セットリスト取得のFuture
  late Future<List<Setlist>> _setlistsFuture;

  @override
  void initState() {
    super.initState();
    _setlistsFuture = ref
        .read(setlistServiceProvider)
        .getSetlistsByMusicId(widget.musicId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Setlist>>(
      future: _setlistsFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final count = snapshot.data!.length;
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.small,
              vertical: AppComponentSpacing.badgeVertical,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(
                AppBorderRadius.medium,
              ),
            ),
            child: Text(
              '${t.setlist.adoption}: $count${t.setlist.times}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: XINXINColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          // エラー時は何も表示しない（またはエラーアイコンを表示）
          return Icon(
            Icons.error,
            size: AppIconSizes.small,
            color: Theme.of(context).colorScheme.error,
          );
        } else {
          // ローディング中は小さなインジケーターを表示
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
