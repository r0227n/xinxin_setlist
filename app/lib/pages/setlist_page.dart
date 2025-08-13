import 'package:app/data/repositories/event_repository.dart';
import 'package:app/data/repositories/music_repository.dart';
import 'package:app/data/services/setlist_service.dart';
import 'package:app/i18n/translations.g.dart';
import 'package:app/router/routes.dart';
import 'package:app_logger/app_logger.dart';
import 'package:cores/cores.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _currentSetlist = Provider<Setlist>((ref) => throw UnimplementedError());
typedef MusicOnPressed = void Function(Music);

/// セットリスト表示ページ
///
/// [eventId]がnullの場合は全てのセットリスト一覧を表示し、
/// [musicId]が指定されている場合はその音楽を含むセットリストを表示し、
/// いずれかのIDが指定されている場合は対応するセットリストを表示する
class SetlistPage extends ConsumerStatefulWidget {
  const SetlistPage({
    this.eventId,
    this.musicId,
    super.key,
  });

  /// オプション引数：指定されたイベントのセットリストを表示する場合のイベントID
  final String? eventId;

  /// オプション引数：指定された音楽を含むセットリストを表示する場合の音楽ID
  final String? musicId;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('eventId', eventId));
    properties.add(StringProperty('musicId', musicId));
  }

  @override
  ConsumerState<SetlistPage> createState() => _SetlistPageState();
}

class _SetlistPageState extends ConsumerState<SetlistPage> with LoggerMixin {
  /// 全ての状態を`List<Setlist>`で管理
  late final Future<List<Setlist>> _setlistsFuture;

  @override
  void initState() {
    super.initState();
    // initStateでFutureを初期化
    _initializeSetlistsFuture();
  }

  /// セットリストFutureの初期化
  void _initializeSetlistsFuture() {
    // eventIdとmusicIdが両方指定されている場合はエラー
    if (widget.eventId != null && widget.musicId != null) {
      _setlistsFuture = Future.error(t.setlist.error.bothIdsSpecified);
      logError('EventIDとMusicIDが両方指定されています');
      return;
    }

    if (widget.eventId != null) {
      // eventIdが指定されている場合、そのイベントのセットリストのみを取得
      _setlistsFuture = ref
          .read(setlistServiceProvider)
          .getSetlist(widget.eventId!)
          .then((setlist) => [setlist]);
      logInfo('EventID指定でセットリスト初期化: ${widget.eventId}');
    } else if (widget.musicId != null) {
      // musicIdが指定されている場合、その音楽を含むセットリストを取得
      _setlistsFuture = ref
          .read(setlistServiceProvider)
          .getSetlistsByMusicId(widget.musicId!);
      logInfo('MusicID指定でセットリスト初期化: ${widget.musicId}');
    } else {
      // どちらも指定されていない場合、全てのセットリストを取得
      _setlistsFuture = ref.read(setlistServiceProvider).getSetlists();
      logInfo('全セットリスト一覧を初期化');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.musicId != null
          ? null
          : AppBar(
              title: Text(t.setlist.title),
              actions: [
                IconButton(
                  onPressed: () => const SettingsRoute().go(context),
                  icon: const Icon(Icons.settings),
                ),
              ],
            ),
      body: FutureBuilder<List<Setlist>>(
        future: _setlistsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            logError('セットリスト取得エラー: ${snapshot.error}');
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16,
                children: [
                  Icon(
                    Icons.error,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  Text(
                    '${t.setlist.error.occurred}: ${snapshot.error}',
                  ),
                  ElevatedButton(
                    onPressed: () => setState(_initializeSetlistsFuture),
                    child: Text(t.dialog.retry),
                  ),
                ],
              ),
            );
          }

          final setlists = snapshot.data!;
          logInfo('セットリスト表示: ${setlists.length}件');

          if (setlists.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16,
                children: [
                  Icon(
                    Icons.library_music,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  Text(_getEmptyMessage()),
                ],
              ),
            );
          }

          // 統合されたセットリスト表示
          return Consumer(
            builder: (context, ref, child) {
              final eventRepositoryAsync = ref.watch(eventRepositoryProvider);

              return switch (eventRepositoryAsync) {
                AsyncData(value: final events) => () {
                  // EventのdateとorderでSetlistをソート
                  final sortedSetlists = [...setlists]
                    ..sort((a, b) {
                      final eventA = events.firstWhere(
                        (e) => e.id == a.eventId,
                        orElse: () => Event(
                          id: '',
                          stageId: '',
                          title: '',
                          date: DateTime.fromMillisecondsSinceEpoch(0),
                          setlist: [],
                          order: 0,
                        ),
                      );
                      final eventB = events.firstWhere(
                        (e) => e.id == b.eventId,
                        orElse: () => Event(
                          id: '',
                          stageId: '',
                          title: '',
                          date: DateTime.fromMillisecondsSinceEpoch(0),
                          setlist: [],
                          order: 0,
                        ),
                      );

                      // 日付で降順ソート（新しい日付が先）
                      final dateComparison = eventB.date.compareTo(eventA.date);
                      if (dateComparison != 0) {
                        return dateComparison;
                      }

                      // 日付が同じ場合、orderで降順ソート（大きい値が先）
                      return (eventB.order ?? 0).compareTo(eventA.order ?? 0);
                    });

                  return ListView.builder(
                    itemCount: sortedSetlists.length,
                    itemBuilder: (context, index) {
                      final setlist = sortedSetlists[index];
                      return ProviderScope(
                        overrides: [_currentSetlist.overrideWithValue(setlist)],
                        child: const _SetlistTile(),
                      );
                    },
                  );
                }(),
                AsyncError(error: final error) => Center(
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
                    ],
                  ),
                ),
                _ => const Center(child: CircularProgressIndicator()),
              };
            },
          );
        },
      ),
    );
  }

  /// 空状態メッセージを取得
  String _getEmptyMessage() {
    if (widget.eventId != null) {
      return t.setlist.empty.noSetlistForEvent;
    } else if (widget.musicId != null) {
      return t.setlist.empty.noSetlistForMusic;
    } else {
      return t.setlist.empty.noSetlist;
    }
  }
}

/// セットリストカード（一覧表示用）
class _SetlistTile extends ConsumerWidget with LoggerMixin {
  const _SetlistTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventRepositoryAsync = ref.watch(eventRepositoryProvider);
    final setlist = ref.watch(_currentSetlist);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: switch (eventRepositoryAsync) {
        AsyncData(value: final events) => () {
          final event = events.firstWhere(
            (e) => e.id == setlist.eventId,
            orElse: () => Event(
              id: '',
              stageId: '',
              title: t.error,
              date: DateTime.now(),
              setlist: [],
            ),
          );

          return ListTile(
            leading: const Icon(Icons.library_music, size: 40),
            title: Text(
              event.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Text(
                  '${t.setlist.date}: ${event.date.toString().split(' ')[0]}',
                ),

                _WrapSetlist(
                  musicIds: setlist.musicIds,
                  onPressed: (music) => MusicDetailRoute(
                    musicId: music.id,
                  ).go(context),
                ),
              ],
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            isThreeLine: true,
            onTap: () async {
              logInfo('セットリスト詳細をダイアログ表示: ${setlist.id}');

              // TODO: セットリスト詳細画面作成後、遷移するように書き換える
              // 現状仮置きとして、ダイアログで表示する
              final musics = await ref
                  .read(musicRepositoryProvider.notifier)
                  .getByMusicIds(setlist.musicIds);
              if (musics.isEmpty || !context.mounted) {
                return;
              }
              await showDialog<void>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(event.title),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: [
                        for (var index = 0; index < musics.length; index++) ...[
                          Text('${index + 1}. ${musics[index].title}'),
                        ],
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(t.dialog.close),
                    ),
                  ],
                ),
              );
            },
          );
        }(),
        AsyncError(error: final error) => ListTile(
          leading: Icon(
            Icons.error,
            color: Theme.of(context).colorScheme.error,
          ),
          title: Text('セットリストID: ${setlist.id}'),
          subtitle: Text(
            '${t.setlist.error.dataFetchFailed}: $error',
          ),
        ),
        _ => ListTile(
          leading: const Icon(Icons.library_music, size: 40),
          title: Text(t.setlist.loading),
          subtitle: const LinearProgressIndicator(),
        ),
      },
    );
  }
}

class _WrapSetlist extends ConsumerStatefulWidget {
  const _WrapSetlist({
    required List<String> musicIds,
    required MusicOnPressed onPressed,
  }) : _musicOrderIds = musicIds,
       _onPressed = onPressed;

  final List<String> _musicOrderIds;
  final MusicOnPressed _onPressed;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WrapSetlistState();
}

class _WrapSetlistState extends ConsumerState<_WrapSetlist> {
  late final Future<List<Music>> _asyncMusic;

  @override
  void initState() {
    super.initState();
    _asyncMusic = ref
        .read(musicRepositoryProvider.notifier)
        .getByMusicIds(widget._musicOrderIds);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _asyncMusic,
      builder: (context, snapshot) {
        return switch ((snapshot.connectionState, snapshot.hasData)) {
          (ConnectionState.done, true) => Wrap(
            spacing: 4,
            runSpacing: 4,
            children:
                snapshot.data
                    ?.map(
                      (e) => ActionChip(
                        avatar: Image.network(
                          e.thumbnailUrl,
                          loadingBuilder: (context, child, loadingProgress) =>
                              loadingProgress == null
                              ? child
                              : const CircularProgressIndicator(),
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.error),
                        ),
                        label: Text(e.title),
                        onPressed: () {
                          widget._onPressed(e);
                        },
                      ),
                    )
                    .toList() ??
                [],
          ),
          (ConnectionState.done, false) => const Icon(Icons.error),
          (ConnectionState.waiting, _) => const CircularProgressIndicator(),
          (_, _) => const Icon(Icons.error),
        };
      },
    );
  }
}
