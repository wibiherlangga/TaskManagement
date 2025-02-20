import 'package:task_management/features/home/domain/repository/home_repository.dart';
import 'package:task_management/shared/model/task_entity.dart';

class HomeUseCase {
  final HomeRepository _homeRepository;

  HomeUseCase(
    this._homeRepository,
  );

  Future<List<TaskEntity>> getTasks() async {
    try {
      final result = await _homeRepository.getTasks();
      return result;
    } catch (_) {
      return [];
    }
  }

  Future<int> deleteTask(int id) async {
    try {
      final result = await _homeRepository.deleteTask(id);
      return result;
    } catch (_) {
      return 0;
    }
  }
}
