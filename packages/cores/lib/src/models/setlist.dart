import 'package:freezed_annotation/freezed_annotation.dart';

part 'setlist.freezed.dart';
part 'setlist.g.dart';

@freezed
abstract class Setlist with _$Setlist {
  const factory Setlist({
    required String id,
    required List<String> musicOrderIds, // music_orderのidを列挙管理
  }) = _Setlist;

  factory Setlist.fromJson(Map<String, dynamic> json) =>
      _$SetlistFromJson(json);
}
