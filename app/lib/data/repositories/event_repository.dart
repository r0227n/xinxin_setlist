import 'dart:convert';

import 'package:app_logger/app_logger.dart';
import 'package:cores/cores.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'event_repository.g.dart';

@Riverpod(keepAlive: true)
class EventRepository extends _$EventRepository with LoggerMixin {
  @override
  FutureOr<List<Event>> build() async {
    final eventJson = await rootBundle.loadString('assets/event.json');
    final jsonList = jsonDecode(eventJson) as List<dynamic>;
    logInfo(eventJson);
    return jsonList
        .map((e) => Event.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Event> get(String eventId) async {
    final events = await future;
    return events.firstWhere((e) => e.id == eventId);
  }

  Future<List<String>> getAllIds() async {
    final events = await future;
    return events.map((e) => e.id.value).toList();
  }

  Future<List<Event>> whereFromMusicId(String musicId) async {
    final events = await future;
    return events
        .where((e) => e.setlist.any((item) => item.musicId == musicId))
        .toList();
  }
}
