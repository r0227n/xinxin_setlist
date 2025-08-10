// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MusicOrder _$MusicOrderFromJson(Map<String, dynamic> json) => _MusicOrder(
  id: json['id'] as String,
  eventId: json['event_id'] as String,
  musicId: json['music_id'] as String,
  order: (json['order'] as num).toInt(),
);

Map<String, dynamic> _$MusicOrderToJson(_MusicOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'music_id': instance.musicId,
      'order': instance.order,
    };
