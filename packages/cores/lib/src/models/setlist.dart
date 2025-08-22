import 'package:cores/src/models/event.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'setlist.freezed.dart';
part 'setlist.g.dart';

extension type SetlistId(String value) {
  factory SetlistId.fromJson(String value) => SetlistId(value);
}

@Freezed(toJson: false)
abstract class Setlist with _$Setlist {
  const factory Setlist({
    @JsonKey(fromJson: SetlistId.fromJson) required SetlistId id,
    @JsonKey(name: 'event_id') required EventId eventId,
    required List<SetlistItemId> musicIds,
  }) = _Setlist;

  factory Setlist.fromJson(Map<String, dynamic> json) =>
      _$SetlistFromJson(json);
}
