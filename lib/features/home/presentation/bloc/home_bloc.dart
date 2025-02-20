import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/features/home/domain/usecase/home_usecase.dart';
import 'package:task_management/shared/model/task_entity.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUseCase _homeUseCase;

  HomeBloc(
    this._homeUseCase,
  ) : super(HomeInitial()) {
    on<GetTaskEvent>(_onGetTaskEvent);
    on<DeleteTaskEvent>(_onDeleteEvent);
  }

  Future<void> _onGetTaskEvent(
    GetTaskEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      HomeLoading(true),
    );

    final tasks = await _homeUseCase.getTasks();

    emit(
      HomeLoading(false),
    );

    emit(
      HomeSuccess(tasks),
    );
  }

  Future<void> _onDeleteEvent(
    DeleteTaskEvent event,
    Emitter<HomeState> emit,
  ) async {
    HomeLoading(true);

    final result = await _homeUseCase.deleteTask(event.id);

    emit(
      HomeLoading(false),
    );

    var tasks = event.tasks;

    tasks.removeWhere(
      (task) => task.id == result,
    );

    emit(
      HomeSuccess(tasks),
    );
  }
}
