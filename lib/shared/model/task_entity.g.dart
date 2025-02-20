// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskEntity _$TaskEntityFromJson(Map<String, dynamic> json) => TaskEntity(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title'] as String,
      description: json['description'] as String,
      date: json['date'] as String,
      status: $enumDecode(_$EnumTaskStatusEnumMap, json['status']),
    );

const _$EnumTaskStatusEnumMap = {
  EnumTaskStatus.pending: 'pending',
  EnumTaskStatus.inProgress: 'inProgress',
  EnumTaskStatus.completed: 'completed',
};
