import 'package:freezed_annotation/freezed_annotation.dart';

part 'music.freezed.dart';
part 'music.g.dart';

extension type MusicId(String value) {
  factory MusicId.fromJson(String value) => MusicId(value);
}

@Freezed(toJson: false)
abstract class Music with _$Music {
  const factory Music({
    @JsonKey(fromJson: MusicId.fromJson) required MusicId id,
    required String title,
    @JsonKey(name: 'thumbnail_url') required String thumbnailUrl,
    @JsonKey(name: 'youtube_id') String? youtubeId,
  }) = _Music;

  factory Music.fromJson(Map<String, dynamic> json) => _$MusicFromJson(json);
}
