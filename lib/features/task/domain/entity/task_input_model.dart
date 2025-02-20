import 'package:json_annotation/json_annotation.dart';
import 'package:task_management/core/enums/enum_task_status.dart';
import 'package:task_management/shared/model/task_entity.dart';

part 'task_input_model.g.dart';

@JsonSerializable()
class TaskInputModel extends TaskEntity {
  TaskInputModel({
    super.id,
    required super.title,
    required super.description,
    required super.date,
    required super.status,
  });

  factory TaskInputModel.fromJson(Map<String, dynamic> json) =>
      _$TaskInputModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskInputModelToJson(this);
}
