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
  order: (json['order'] as num?)?.toInt(),
);

Map<String, dynamic> _$EventToJson(_Event instance) => <String, dynamic>{
  'id': instance.id,
  'stage_id': instance.stageId,
  'title': instance.title,
  'date': instance.date.toIso8601String(),
  'order': instance.order,
};
