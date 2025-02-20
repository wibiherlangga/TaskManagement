// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_input_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskInputModel _$TaskInputModelFromJson(Map<String, dynamic> json) =>
    TaskInputModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title'] as String,
      description: json['description'] as String,
      date: json['date'] as String,
      status: $enumDecode(_$EnumTaskStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$TaskInputModelToJson(TaskInputModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'date': instance.date,
      'status': _$EnumTaskStatusEnumMap[instance.status]!,
    };

const _$EnumTaskStatusEnumMap = {
  EnumTaskStatus.pending: 'pending',
  EnumTaskStatus.inProgress: 'inProgress',
  EnumTaskStatus.completed: 'completed',
};
