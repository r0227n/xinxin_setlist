import 'package:app/data/repositories/event_repository.dart';
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
    musicRepository: ref.watch(musicRepositoryProvider.notifier),
    eventRepository: ref.watch(eventRepositoryProvider.notifier),
  );
}

class SetlistService with LoggerMixin {
  SetlistService({
    required MusicRepository musicRepository,
    required EventRepository eventRepository,
  }) : _musicRepository = musicRepository,
       _eventRepository = eventRepository;

  final MusicRepository _musicRepository;
  final EventRepository _eventRepository;

  /// [eventId] セットリストを作成する対象のイベントID
  Future<Setlist> getSetlist(String eventId) async {
    // イベントを取得
    final targetEvent = await _eventRepository.get(eventId);

    logInfo(
      'Creating setlist for event: ${targetEvent.title} (ID: $eventId)',
    );

    // イベントのsetlistから楽曲IDを順序順に取得
    final orderedSetlist = targetEvent.setlist.toList()
      ..sort((a, b) => a.order.compareTo(b.order));
    final musicIds = orderedSetlist.map((item) => item.musicId).toList();

    logInfo(
      '${musicIds.length} musics for event ID: $eventId',
    );

    final setlistId = _generateRandomId(20);

    return Setlist(
      id: setlistId,
      eventId: eventId,
      musicIds: musicIds,
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

  /// [musicId] 指定された音楽を含むセットリストを取得する
  Future<List<Setlist>> getSetlistsByMusicId(String musicId) async {
    // 指定されたmusicIdを含むイベントをフィルタリング
    final matchingEvents = await _eventRepository.whereFromMusicId(musicId);

    logInfo(
      'Found ${matchingEvents.length} events containing music ID: $musicId',
    );

    // マッチしたイベントのセットリストを作成
    final setlists = await Future.wait(
      matchingEvents.map((event) => getSetlist(event.id)),
    );

    return setlists;
  }

  Future<List<Music>> getMusicFromMusicOrderIds(
    List<String> musicIds,
  ) async {
    final musics = await Future.wait(musicIds.map(_musicRepository.get));
    return musics;
  }

  Future<Music> getMusicByMusicId(String musicId) async {
    final music = await _musicRepository.get(musicId);
    return music;
  }

  /// 指定された長さのランダムな文字列IDを生成する
  String _generateRandomId(int length) {
    return _uuid.v4().substring(0, length);
  }
}
