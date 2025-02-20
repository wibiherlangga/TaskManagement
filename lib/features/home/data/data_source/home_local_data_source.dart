import 'package:task_management/features/home/data/model/task_model.dart';
import 'package:task_management/local/task_database.dart';

abstract class HomeLocalDataSource {
  Future<List<TaskModel>> getTasks();
  Future<int> deleteTask(int id);
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  @override
  Future<List<TaskModel>> getTasks() async {
    try {
      final db = await TaskDatabase.instance.database;

      final result = await db.query(
        TaskDatabase.table,
      );

      final tasks = result
          .map(
            (e) => TaskModel.fromJson(e),
          )
          .toList();
      return tasks;
    } catch (_) {
      return [];
    }
  }

  @override
  Future<int> deleteTask(int id) async {
    try {
      final db = await TaskDatabase.instance.database;

      final result = await db.delete(
        TaskDatabase.table,
        where: '${TaskDatabase.columnId} = ?',
        whereArgs: [id],
      );

      return result;
    } catch (_) {
      rethrow;
    }
  }
}
