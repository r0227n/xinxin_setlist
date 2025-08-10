import 'dart:convert';

import 'package:app_logger/app_logger.dart';
import 'package:cores/cores.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'music_order_repository.g.dart';

@Riverpod(keepAlive: true)
class MusicOrderRepository extends _$MusicOrderRepository with LoggerMixin {
  @override
  FutureOr<List<MusicOrder>> build() async {
    final musicOrderJson = await rootBundle.loadString(
      'assets/music_order.json',
    );
    final jsonList = jsonDecode(musicOrderJson) as List<dynamic>;
    logInfo(musicOrderJson);
    return jsonList
        .map((e) => MusicOrder.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
