import 'package:task_management/shared/model/task_entity.dart';
import 'package:task_management/features/task/domain/entity/task_input_model.dart';

abstract class TaskRepository {
  Future<TaskEntity> addTask(TaskInputModel task);
  Future<int> updateTask(TaskInputModel task);
}
