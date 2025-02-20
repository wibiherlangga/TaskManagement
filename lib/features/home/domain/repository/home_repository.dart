import 'package:task_management/shared/model/task_entity.dart';

abstract class HomeRepository {
  Future<List<TaskEntity>> getTasks();
  Future<int> deleteTask(int id);
}
