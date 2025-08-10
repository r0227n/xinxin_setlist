// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Setlist _$SetlistFromJson(Map<String, dynamic> json) => _Setlist(
  id: json['id'] as String,
  eventId: json['eventId'] as String,
  musicOrderIds: (json['musicOrderIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$SetlistToJson(_Setlist instance) => <String, dynamic>{
  'id': instance.id,
  'eventId': instance.eventId,
  'musicOrderIds': instance.musicOrderIds,
};
