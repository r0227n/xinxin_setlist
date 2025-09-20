// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Music _$MusicFromJson(Map<String, dynamic> json) => _Music(
  id: MusicId.fromJson(json['id'] as String),
  title: json['title'] as String,
  thumbnailUrl: json['thumbnail_url'] as String,
  artist: json['artist'] as String? ?? 'XINXIN',
  singers:
      (json['singers'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const ['XINXIN'],
  youtubeId: json['youtube_id'] as String?,
);

Map<String, dynamic> _$MusicToJson(_Music instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'thumbnail_url': instance.thumbnailUrl,
  'artist': instance.artist,
  'singers': instance.singers,
  'youtube_id': instance.youtubeId,
};
