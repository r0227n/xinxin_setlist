// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Setlist _$SetlistFromJson(Map<String, dynamic> json) => _Setlist(
  id: SetlistId.fromJson(json['id'] as String),
  eventId: EventId.fromJson(json['event_id'] as String),
  musicIds: (json['musicIds'] as List<dynamic>)
      .map((e) => SetlistItemId.fromJson(e as String))
      .toList(),
);
