import 'package:app/core/mixin/web_title_mixin.dart';
import 'package:app/data/repositories/music_repository.dart';
import 'package:app/data/services/setlist_service.dart';
import 'package:app/i18n/translations.g.dart';
import 'package:app/pages/setlist_page.dart';
import 'package:app_preferences/app_preferences.dart';
import 'package:cores/cores.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    with ConsumerWebTitleMixin {
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
      debugPrint('楽曲詳細を表示: ${music.title}');
      // ブラウザタブのタイトルを楽曲名に設定
      WidgetsBinding.instance.addPostFrameCallback((_) {
        updatePageTitle(music.title);
      });
      return music;
    } catch (error) {
      debugPrint('楽曲詳細の取得に失敗: $error');
      rethrow;
    }
  }

  /// データを再読み込みする
  void _refreshMusicDetail() {
    setState(() {
      _musicDetailFuture = _loadMusicDetail();
    });
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('musicId', widget.musicId));
    properties.add(StringProperty('pageTitle', pageTitle));
    properties.add(
      DiagnosticsProperty<Future<Music>>(
        'musicDetailFuture',
        _musicDetailFuture,
      ),
    );
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
                final isLargeScreen = constraints.maxWidth > 800;

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
              size: 64,
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
      duration: const Duration(milliseconds: 300),
      child: Padding(
        key: ValueKey(_music.id),
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 左側3割: 楽曲情報カード
            Expanded(
              flex: 3,
              child: _MusicCard(_music),
            ),

            // 右側7割: セットリストページ
            Expanded(
              flex: 7,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
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
      duration: const Duration(milliseconds: 300),
      child: Padding(
        key: ValueKey(_music.id),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24,
          children: [
            // 楽曲情報カード
            _MusicCard(_music),

            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
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
class _MusicCard extends ConsumerWidget {
  const _MusicCard(Music music) : _music = music;

  /// 表示する楽曲データ
  final Music _music;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
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
  const _Thumbnail({
    required Music music,
    double height = 200,
    double width = 200,
  }) : _music = music,
       _height = height,
       _width = width;

  final Music _music;
  final double _height;
  final double _width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          _music.thumbnailUrl,
          height: _height,
          width: _width,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: _height,
              width: _width,
              color: XINXINColors.white,
              child: const Icon(
                Icons.music_note,
                size: 64,
                color: XINXINColors.orange,
              ),
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return SizedBox(
              height: _height,
              width: _width,
              child: const ColoredBox(
                color: XINXINColors.white,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          },
        ),
      ),
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
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(12),
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
            size: 32,
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
