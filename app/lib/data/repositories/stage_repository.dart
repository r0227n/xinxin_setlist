import 'dart:convert';

import 'package:app/data/repositories/event_repository.dart';
import 'package:app_logger/app_logger.dart';
import 'package:cores/cores.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'stage_repository.g.dart';

@Riverpod(keepAlive: true)
class StageRepository extends _$StageRepository with LoggerMixin {
  @override
  FutureOr<List<Stage>> build() async {
    final stageJson = await rootBundle.loadString('assets/stage.json');
    final jsonList = jsonDecode(stageJson) as List<dynamic>;
    logInfo(stageJson);
    return jsonList
        .map((e) => Stage.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// イベントIDからステージを取得する
  Future<Stage?> getFromEventId(String eventId) async {
    final (stages, event) = await (
      future,
      ref.read(eventRepositoryProvider.notifier).get(eventId),
    ).wait;

    return stages.where((stage) => stage.id.value == event.stageId).firstOrNull;
  }
}
