import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';
part 'event.g.dart';

extension type EventId(String value) {
  factory EventId.fromJson(String value) => EventId(value);
  String toJson() => value;
}

extension type SetlistItemId(String value) {
  factory SetlistItemId.fromJson(String value) => SetlistItemId(value);
  String toJson() => value;
}

@freezed
abstract class Event with _$Event {
  const factory Event({
    @JsonKey(fromJson: EventId.fromJson) required EventId id,
    @JsonKey(name: 'stage_id') required String stageId,
    required String title,
    required DateTime date,
    required List<SetlistItem> setlist,
    int? order, // null許容
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}

@freezed
abstract class SetlistItem with _$SetlistItem {
  const factory SetlistItem({
    @JsonKey(
      name: 'music_id',
      fromJson: SetlistItemId.fromJson,
    )
    required SetlistItemId musicId,
    required int order,
  }) = _SetlistItem;

  factory SetlistItem.fromJson(Map<String, dynamic> json) =>
      _$SetlistItemFromJson(json);
}
