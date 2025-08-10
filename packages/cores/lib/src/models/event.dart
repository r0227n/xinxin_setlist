import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';
part 'event.g.dart';

@freezed
abstract class Event with _$Event {
  const factory Event({
    required String id, // date_ランダム
    @JsonKey(name: 'stage_id') required String stageId,
    required String title,
    required DateTime date,
    int? order, // null許容
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}
