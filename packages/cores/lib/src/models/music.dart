import 'package:freezed_annotation/freezed_annotation.dart';

part 'music.freezed.dart';
part 'music.g.dart';

extension type MusicId(String value) {
  factory MusicId.fromJson(String value) => MusicId(value);
  String toJson() => value;
}

@freezed
abstract class Music with _$Music {
  const factory Music({
    @JsonKey(fromJson: MusicId.fromJson) required MusicId id,
    required String title,
    @JsonKey(name: 'thumbnail_url') required String thumbnailUrl,
    @Default('XINXIN') String artist,
    @Default(['XINXIN']) List<String> singers,
    @JsonKey(name: 'youtube_id') String? youtubeId,
  }) = _Music;

  factory Music.fromJson(Map<String, dynamic> json) => _$MusicFromJson(json);
}
