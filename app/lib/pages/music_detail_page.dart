import 'package:app/core/mixin/ogp_mixin.dart';
import 'package:app/data/repositories/music_repository.dart';
import 'package:app/data/services/setlist_service.dart';
import 'package:app/i18n/translations.g.dart';
import 'package:app/pages/setlist_page.dart';
import 'package:app_preferences/app_preferences.dart';
import 'package:cores/cores.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'music_detail_page.g.dart';

/// musicId で指定された楽曲の詳細情報を取得するProvider
@riverpod
Future<Music> musicDetail(Ref ref, String musicId) {
  return ref.watch(musicRepositoryProvider.notifier).get(musicId);
}

/// 楽曲詳細表示ページ
///
/// [musicId]で指定された楽曲の詳細情報を表示し、
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
    with ConsumerWebTitleOgpMixin {
  @override
  String get pageTitle => t.music.detail;

  @override
  String get ogpDescription => '楽曲の詳細情報を表示します';

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('musicId', widget.musicId));
    properties.add(StringProperty('pageTitle', pageTitle));
  }

  @override
  Widget build(BuildContext context) {
    // Riverpodを使用してmusicIdが変更された時に自動的に再取得される
    final musicDetailAsync = ref.watch(musicDetailProvider(widget.musicId));

    // ログ出力（デバッグ用）
    ref.listen<AsyncValue<Music>>(musicDetailProvider(widget.musicId), (
      previous,
      next,
    ) {
      if (next.hasValue) {
        final music = next.value!;
        debugPrint('楽曲詳細を表示: ${music.title}');

        // ブラウザタブのタイトルとOGPを楽曲情報に設定
        updatePageTitleAndOgp(
          music.title,
          newDescription: '楽曲ID: ${music.id} - XINXIN SETLISTで詳細を確認',
        );

        // 楽曲専用のOGP設定（動的画像生成含む）
        setMusicOgp(music);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(t.music.detail),
      ),
      body: switch (musicDetailAsync) {
        AsyncData(value: final music) => AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Padding(
            key: ValueKey(music.id),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 楽曲情報カード
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 16,
                      children: [
                        // サムネイル画像
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              music.thumbnailUrl,
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 200,
                                  width: 200,
                                  color: XINXINColors.white,
                                  child: const Icon(
                                    Icons.music_note,
                                    size: 64,
                                    color: XINXINColors.orange,
                                  ),
                                );
                              },
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return Container(
                                      height: 200,
                                      width: 200,
                                      color: XINXINColors.white,
                                      child: const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  },
                            ),
                          ),
                        ),

                        // 楽曲タイトル
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                music.title,
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineMedium,
                              ),
                            ),
                            FutureBuilder<List<Setlist>>(
                              future: ref
                                  .read(setlistServiceProvider)
                                  .getSetlistsByMusicId(music.id),
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
                                      // Adoption count display
                                      // ignore: lines_longer_than_80_chars
                                      '${t.setlist.adoption}: $count${t.setlist.times}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: XINXINColors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ],
                        ),

                        // 楽曲ID（デバッグ用）
                        if (kDebugMode) ...[
                          Text(
                            'ID: ${music.id}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: SetlistPage(
                      key: ValueKey('setlist_${music.id}'),
                      musicId: music.id,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        AsyncError(error: final error, stackTrace: final _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children: [
              Icon(
                Icons.error,
                size: 64,
                color: Theme.of(context).colorScheme.error,
              ),
              Text('${t.setlist.error.occurred}: $error'),
              ElevatedButton(
                onPressed: () {
                  // Providerを無効化して再取得を促す
                  ref.invalidate(musicDetailProvider(widget.musicId));
                },
                child: Text(t.dialog.retry),
              ),
            ],
          ),
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}
