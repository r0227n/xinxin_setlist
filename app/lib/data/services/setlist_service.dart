import 'package:app/data/repositories/event_repository.dart';
import 'package:app_logger/app_logger.dart';
import 'package:cores/cores.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'setlist_service.g.dart';

@riverpod
SetlistService setlistService(Ref ref) {
  return SetlistService(
    eventRepository: ref.watch(eventRepositoryProvider.notifier),
  );
}

class SetlistService with LoggerMixin {
  SetlistService({
    required EventRepository eventRepository,
  }) : _eventRepository = eventRepository;

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

    return Setlist(
      id: targetEvent.id,
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
}
