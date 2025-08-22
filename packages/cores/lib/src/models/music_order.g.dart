// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MusicOrder _$MusicOrderFromJson(Map<String, dynamic> json) => _MusicOrder(
  id: MusicOrderId.fromJson(json['id'] as String),
  eventId: EventId.fromJson(json['event_id'] as String),
  musicId: MusicId.fromJson(json['music_id'] as String),
  order: (json['order'] as num).toInt(),
);
