import 'package:json_annotation/json_annotation.dart';
import 'package:task_management/core/enums/enum_task_status.dart';

part 'task_entity.g.dart';

@JsonSerializable()
class TaskEntity {
  final int id;
  final String title;
  final String description;
  final String date;
  final EnumTaskStatus status;

  TaskEntity({
    this.id = 0,
    required this.title,
    required this.description,
    required this.date,
    required this.status,
  });

  factory TaskEntity.fromJson(Map<String, Object?> json) =>
      _$TaskEntityFromJson(json);
}
