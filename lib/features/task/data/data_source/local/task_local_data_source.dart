import 'package:task_management/features/task/domain/entity/task_input_model.dart';
import 'package:task_management/local/task_database.dart';

abstract class TaskLocalDataSource {
  Future<TaskInputModel> addTask(TaskInputModel task);
  Future<int> updateTask(TaskInputModel task);
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  @override
  Future<TaskInputModel> addTask(TaskInputModel task) async {
    final db = await TaskDatabase.instance.database;
    final id = await db.insert(
      TaskDatabase.table,
      task.toJson(),
    );

    final taskAdded = TaskInputModel(
      id: id,
      title: task.title,
      description: task.description,
      date: task.date,
      status: task.status,
    );

    return taskAdded;
  }

  @override
  Future<int> updateTask(TaskInputModel task) async {
    final db = await TaskDatabase.instance.database;
    final id = await db.update(
      TaskDatabase.table,
      task.toJson(),
    );

    return id;
  }
}
