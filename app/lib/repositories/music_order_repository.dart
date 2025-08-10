import 'dart:convert';

import 'package:app/repositories/event_repository.dart';
import 'package:app_logger/app_logger.dart';
import 'package:cores/cores.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'music_order_repository.g.dart';

const _uuid = Uuid();

@riverpod
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

  /// [eventId] セットリストを作成する対象のイベントID
  Future<Setlist> getSetlist(String eventId) async {
    // musicOrdersの初期化完了を確実に待つ
    final musicOrders = await future;
    if (musicOrders.isEmpty) {
      throw Exception('MusicOrders is empty');
    }

    final events = await ref.read(eventRepositoryProvider.future);

    // イベントIDが存在するかチェック（ログ出力のため）
    final targetEvent = events
        .where((event) => event.id == eventId)
        .firstOrNull;
    if (targetEvent != null) {
      logInfo(
        'Creating setlist for event: ${targetEvent.title} (ID: $eventId)',
      );
    } else {
      logInfo('Event not found for ID: $eventId. Creating empty setlist.');
    }

    logInfo('MusicOrders: $musicOrders');

    final filteredMusicOrderIds = musicOrders
        .where((musicOrder) => musicOrder.eventId == eventId)
        .map((musicOrder) => musicOrder.id)
        .toList();

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
    final events = await ref.read(eventRepositoryProvider.future);
    final setlists = await Future.wait(
      events.map((event) => getSetlist(event.id)),
    );
    return setlists;
  }

  /// 指定された楽曲IDを含むセットリストを取得
  Future<MusicOrder> get(String musicOrderId) async {
    final musicOrders = await future;
    return musicOrders.firstWhere(
      (musicOrder) => musicOrder.id == musicOrderId,
    );
  }

  /// 指定された長さのランダムな文字列IDを生成する
  String _generateRandomId(int length) {
    return _uuid.v4().substring(0, length);
  }
}
