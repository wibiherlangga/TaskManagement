import 'package:task_management/features/task/data/data_source/local/task_local_data_source.dart';
import 'package:task_management/shared/model/task_entity.dart';
import 'package:task_management/features/task/domain/entity/task_input_model.dart';
import 'package:task_management/features/task/domain/repository/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource _dataSource;

  TaskRepositoryImpl(
    this._dataSource,
  );

  @override
  Future<TaskEntity> addTask(TaskInputModel task) async {
    final result = await _dataSource.addTask(task);
    return result;
  }

  @override
  Future<int> updateTask(TaskInputModel task) async {
    final result = await _dataSource.updateTask(task);

    if (result == 1) return task.id;

    return 0;
  }
}
