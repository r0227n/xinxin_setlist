import 'package:app/data/repositories/event_repository.dart';
import 'package:app/data/repositories/music_order_repository.dart';
import 'package:app/data/repositories/music_repository.dart';
import 'package:app_logger/app_logger.dart';
import 'package:cores/cores.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'setlist_service.g.dart';

const _uuid = Uuid();

@riverpod
SetlistService setlistService(Ref ref) {
  return SetlistService(
    musicOrderRepository: ref.watch(musicOrderRepositoryProvider.notifier),
    musicRepository: ref.watch(musicRepositoryProvider.notifier),
    eventRepository: ref.watch(eventRepositoryProvider.notifier),
  );
}

class SetlistService with LoggerMixin {
  SetlistService({
    required MusicOrderRepository musicOrderRepository,
    required MusicRepository musicRepository,
    required EventRepository eventRepository,
  }) : _musicOrderRepository = musicOrderRepository,
       _musicRepository = musicRepository,
       _eventRepository = eventRepository;

  final MusicOrderRepository _musicOrderRepository;
  final MusicRepository _musicRepository;
  final EventRepository _eventRepository;

  /// [eventId] セットリストを作成する対象のイベントID
  Future<Setlist> getSetlist(String eventId) async {
    // イベントIDが存在するかチェック（ログ出力のため）
    final (targetEvent, filteredMusicOrderIds) = await (
      _eventRepository.get(eventId),
      _musicOrderRepository.filterMusicOrderIdsByEventId(eventId),
    ).wait;

    logInfo(
      'Creating setlist for event: ${targetEvent.title} (ID: $eventId)',
    );

    logInfo(
      '${filteredMusicOrderIds.length} music orders for event ID: $eventId',
    );

    final setlistId = _generateRandomId(20);

    return Setlist(
      id: setlistId,
      eventId: eventId,
      musicOrderIds: filteredMusicOrderIds,
    );
  }

  /// 全てのイベントに対してセットリストを作成する
  Future<List<Setlist>> getSetlists() async {
    final eventIds = await _eventRepository.getAllIds();
    final setlists = await Future.wait(
      eventIds.map(getSetlist),
    );
    return setlists;
  }

  Future<List<Music>> getMusicFromMusicOrderIds(
    List<String> musicOrderIds,
  ) async {
    final musics = await Future.wait(musicOrderIds.map(getMusicByMusicOrderId));
    return musics;
  }

  Future<Music> getMusicByMusicOrderId(String musicOrderId) async {
    final musicOrder = await _musicOrderRepository.get(musicOrderId);
    final music = await _musicRepository.get(musicOrder.musicId);
    return music;
  }

  /// 指定された長さのランダムな文字列IDを生成する
  String _generateRandomId(int length) {
    return _uuid.v4().substring(0, length);
  }
}
