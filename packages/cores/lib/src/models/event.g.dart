// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Event _$EventFromJson(Map<String, dynamic> json) => _Event(
  id: EventId.fromJson(json['id'] as String),
  stageId: json['stage_id'] as String,
  title: json['title'] as String,
  date: DateTime.parse(json['date'] as String),
  setlist: (json['setlist'] as List<dynamic>)
      .map((e) => SetlistItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  order: (json['order'] as num?)?.toInt(),
);

_SetlistItem _$SetlistItemFromJson(Map<String, dynamic> json) => _SetlistItem(
  musicId: SetlistItemId.fromJson(json['music_id'] as String),
  order: (json['order'] as num).toInt(),
);
