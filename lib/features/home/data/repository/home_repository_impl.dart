import 'package:task_management/features/home/data/data_source/home_local_data_source.dart';
import 'package:task_management/features/home/domain/repository/home_repository.dart';
import 'package:task_management/shared/model/task_entity.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDataSource _homeLocalDataSource;

  HomeRepositoryImpl(
    this._homeLocalDataSource,
  );

  @override
  Future<List<TaskEntity>> getTasks() async {
    try {
      final result = await _homeLocalDataSource.getTasks();

      final tasksEntity = result
          .map(
            (e) => e.toEntity(),
          )
          .toList();

      return tasksEntity;
    } catch (_) {
      return [];
    }
  }

  @override
  Future<int> deleteTask(int id) async {
    try {
      final result = await _homeLocalDataSource.deleteTask(id);

      // If 1 == success, then return our task id
      if (result == 1) {
        return id;
      }

      return 0;
    } catch (_) {
      return 0;
    }
  }
}
