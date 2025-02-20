import 'package:task_management/shared/model/task_entity.dart';
import 'package:task_management/features/task/domain/entity/task_input_model.dart';
import 'package:task_management/features/task/domain/repository/task_repository.dart';

class TaskUseCase {
  final TaskRepository _taskRepository;

  const TaskUseCase(
    this._taskRepository,
  );

  Future<TaskEntity> addTask(
    TaskInputModel task,
  ) async {
    return await _taskRepository.addTask(task);
  }

  Future<int> updateTask(
    TaskInputModel task,
  ) async {
    return await _taskRepository.updateTask(task);
  }
}
