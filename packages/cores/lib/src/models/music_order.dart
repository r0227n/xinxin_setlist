import 'package:cores/src/models/event.dart';
import 'package:cores/src/models/music.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'music_order.freezed.dart';
part 'music_order.g.dart';

extension type MusicOrderId(String value) {
  factory MusicOrderId.fromJson(String value) => MusicOrderId(value);
}

@Freezed(toJson: false)
abstract class MusicOrder with _$MusicOrder {
  const factory MusicOrder({
    required MusicOrderId id,
    @JsonKey(name: 'event_id') required EventId eventId, // 外部キー
    @JsonKey(name: 'music_id') required MusicId musicId, // 外部キー
    required int order,
  }) = _MusicOrder;

  factory MusicOrder.fromJson(Map<String, dynamic> json) =>
      _$MusicOrderFromJson(json);
}
