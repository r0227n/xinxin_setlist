// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MusicOrder _$MusicOrderFromJson(Map<String, dynamic> json) => _MusicOrder(
  id: json['id'] as String,
  eventId: json['eventId'] as String,
  musicId: json['musicId'] as String,
  order: (json['order'] as num).toInt(),
);

Map<String, dynamic> _$MusicOrderToJson(_MusicOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eventId': instance.eventId,
      'musicId': instance.musicId,
      'order': instance.order,
    };
