// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Event _$EventFromJson(Map<String, dynamic> json) => _Event(
  id: json['id'] as String,
  stageId: json['stage_id'] as String,
  title: json['title'] as String,
  date: DateTime.parse(json['date'] as String),
  setlist: (json['setlist'] as List<dynamic>)
      .map((e) => SetlistItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  order: (json['order'] as num?)?.toInt(),
);

Map<String, dynamic> _$EventToJson(_Event instance) => <String, dynamic>{
  'id': instance.id,
  'stage_id': instance.stageId,
  'title': instance.title,
  'date': instance.date.toIso8601String(),
  'setlist': instance.setlist,
  'order': instance.order,
};

_SetlistItem _$SetlistItemFromJson(Map<String, dynamic> json) => _SetlistItem(
  id: json['id'] as String,
  musicId: json['music_id'] as String,
  order: (json['order'] as num).toInt(),
);

Map<String, dynamic> _$SetlistItemToJson(_SetlistItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'music_id': instance.musicId,
      'order': instance.order,
    };
