import 'package:app/repositories/music_order_repository.dart';
import 'package:app/repositories/music_repository.dart';
import 'package:cores/cores.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'setlist_service.g.dart';

@riverpod
SetlistService setlistService(Ref ref) {
  return SetlistService(
    musicOrderRepository: ref.watch(musicOrderRepositoryProvider.notifier),
    musicRepository: ref.watch(musicRepositoryProvider.notifier),
  );
}

class SetlistService {
  SetlistService({
    required MusicOrderRepository musicOrderRepository,
    required MusicRepository musicRepository,
  }) : _musicOrderRepository = musicOrderRepository,
       _musicRepository = musicRepository;

  final MusicOrderRepository _musicOrderRepository;
  final MusicRepository _musicRepository;

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
}
