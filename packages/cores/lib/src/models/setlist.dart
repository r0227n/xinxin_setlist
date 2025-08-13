import 'package:freezed_annotation/freezed_annotation.dart';

part 'setlist.freezed.dart';
part 'setlist.g.dart';

@freezed
abstract class Setlist with _$Setlist {
  const factory Setlist({
    required String id,
    required String eventId,
    required List<String> musicIds,
  }) = _Setlist;

  factory Setlist.fromJson(Map<String, dynamic> json) =>
      _$SetlistFromJson(json);
}
