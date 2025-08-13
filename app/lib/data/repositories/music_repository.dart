import 'dart:convert';

import 'package:app_logger/app_logger.dart';
import 'package:cores/cores.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'music_repository.g.dart';

@Riverpod(keepAlive: true)
class MusicRepository extends _$MusicRepository with LoggerMixin {
  @override
  FutureOr<List<Music>> build() async {
    final musicJson = await rootBundle.loadString('assets/music.json');
    final jsonList = jsonDecode(musicJson) as List<dynamic>;
    logInfo(musicJson);
    return jsonList
        .map((e) => Music.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Music> get(String musicId) async {
    final music = await future;
    return music.firstWhere((music) => music.id == musicId);
  }

  Future<List<Music>> getByMusicIds(List<String> musicIds) async {
    final music = await future;
    logInfo('musicIds: $musicIds');
    // musicIdsの順番通りにMusicを取得して返す
    return musicIds
        .map(
          (id) => music.firstWhere(
            (m) => m.id == id,
          ),
        )
        .cast<Music>()
        .toList();
  }
}
