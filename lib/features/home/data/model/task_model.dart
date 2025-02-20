import 'package:json_annotation/json_annotation.dart';
import 'package:task_management/core/enums/enum_task_status.dart';
import 'package:task_management/core/mixin/entity_convertible_mixin.dart';
import 'package:task_management/shared/model/task_entity.dart';

part 'task_model.g.dart';

@JsonSerializable()
class TaskModel with EntityConvertibleMixin<TaskModel, TaskEntity> {
  final int id;
  final String title;
  final String description;
  final String date;
  final String status;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.status,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  @override
  TaskEntity toEntity() {
    return TaskEntity(
      id: id,
      title: title,
      description: description,
      date: date,
      status: _getEnumTaskStatus(status),
    );
  }

  EnumTaskStatus _getEnumTaskStatus(String status) {
    switch (status) {
      case 'pending':
        return EnumTaskStatus.pending;
      case 'inProgress':
        return EnumTaskStatus.inProgress;
      case 'completed':
        return EnumTaskStatus.completed;
      default:
        return EnumTaskStatus.completed;
    }
  }
}
