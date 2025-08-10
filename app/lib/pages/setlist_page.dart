import 'package:app/data/repositories/event_repository.dart';
import 'package:app/data/services/setlist_service.dart';
import 'package:app/pages/widgets/music_chip.dart';
import 'package:app_logger/app_logger.dart';
import 'package:cores/cores.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _currentSetlist = Provider<Setlist>((ref) => throw UnimplementedError());

/// セットリスト表示ページ
///
/// [eventId]がnullの場合は全てのセットリスト一覧を表示し、
/// いずれかのIDが指定されている場合は対応するセットリストを表示する
class SetlistPage extends ConsumerStatefulWidget {
  const SetlistPage({
    this.eventId,

    super.key,
  });

  /// オプション引数：指定されたイベントのセットリストを表示する場合のイベントID
  final String? eventId;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('eventId', eventId));
  }

  @override
  ConsumerState<SetlistPage> createState() => _SetlistPageState();
}

class _SetlistPageState extends ConsumerState<SetlistPage> with LoggerMixin {
  /// 全ての状態をList<Setlist>で管理
  late final Future<List<Setlist>> _setlistsFuture;

  @override
  void initState() {
    super.initState();
    // initStateでFutureを初期化
    _initializeSetlistsFuture();
  }

  /// セットリストFutureの初期化
  void _initializeSetlistsFuture() {
    if (widget.eventId != null) {
      // eventIdが指定されている場合、そのイベントのセットリストのみを取得
      _setlistsFuture = ref
          .read(setlistServiceProvider)
          .getSetlist(widget.eventId!)
          .then((setlist) => [setlist]);
      logInfo('EventID指定でセットリスト初期化: ${widget.eventId}');
    } else {
      // どちらも指定されていない場合、全てのセットリストを取得
      _setlistsFuture = ref.read(setlistServiceProvider).getSetlists();
      logInfo('全セットリスト一覧を初期化');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('セットリスト'),
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
                children: [
                  const Icon(Icons.error, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('エラーが発生しました: ${snapshot.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => setState(_initializeSetlistsFuture),
                    child: const Text('再試行'),
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
                children: [
                  const Icon(Icons.library_music, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(_getEmptyMessage()),
                ],
              ),
            );
          }

          // 統合されたセットリスト表示
          return ListView.builder(
            itemCount: setlists.length,
            itemBuilder: (context, index) {
              final setlist = setlists[index];
              return ProviderScope(
                overrides: [_currentSetlist.overrideWithValue(setlist)],
                child: const _SetlistTile(),
              );
            },
          );
        },
      ),
    );
  }

  /// 空状態メッセージを取得
  String _getEmptyMessage() {
    if (widget.eventId != null) {
      return 'このイベントにはセットリストがありません';
    } else {
      return 'セットリストがありません';
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
            orElse: () =>
                Event(id: '', stageId: '', title: 'エラー', date: DateTime.now()),
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
                  '日付: ${event.date.year}年${event.date.month}月${event.date.day}日',
                ),

                WrapSetlist(
                  musicOrderIds: setlist.musicOrderIds,
                  onPressed: (music) {
                    logInfo('${music.title}を再生');
                  },
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
                  .read(setlistServiceProvider)
                  .getMusicFromMusicOrderIds(setlist.musicOrderIds);
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
                      child: const Text('閉じる'),
                    ),
                  ],
                ),
              );
            },
          );
        }(),
        AsyncError(error: final error) => ListTile(
          leading: const Icon(Icons.error, color: Colors.red),
          title: Text('セットリストID: ${setlist.id}'),
          subtitle: Text('データ取得に失敗: $error'),
        ),
        _ => const ListTile(
          leading: Icon(Icons.library_music, size: 40),
          title: Text('読み込み中...'),
          subtitle: LinearProgressIndicator(),
        ),
      },
    );
  }
}
