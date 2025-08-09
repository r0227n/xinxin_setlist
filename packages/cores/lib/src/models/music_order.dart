import 'package:freezed_annotation/freezed_annotation.dart';

part 'music_order.freezed.dart';
part 'music_order.g.dart';

@freezed
abstract class MusicOrder with _$MusicOrder {
  const factory MusicOrder({
    required String id, // ランダム
    required String eventId, // 外部キー
    required String musicId, // 外部キー
    required int order,
  }) = _MusicOrder;

  factory MusicOrder.fromJson(Map<String, dynamic> json) =>
      _$MusicOrderFromJson(json);
}
