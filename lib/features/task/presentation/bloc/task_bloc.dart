import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/core/constants/app_constants.dart';
import 'package:task_management/features/task/domain/entity/task_input_model.dart';
import 'package:task_management/features/task/domain/usecase/task_usecase.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskUseCase _taskUseCase;

  TaskBloc(
    this._taskUseCase,
  ) : super(SnackBarStateNone()) {
    on<AddTaskEvent>(_onAddTaskEvent);
    on<UpdateTaskEvent>(_onUpdateTaskEvent);
  }

  Future<void> _onAddTaskEvent(
    AddTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    final id = DateTime.now().millisecondsSinceEpoch;

    final task = TaskInputModel(
      id: id,
      title: event.task.title,
      description: event.task.description,
      date: event.task.date,
      status: event.task.status,
    );
    final result = await _taskUseCase.addTask(task);

    if (result.id == id) {
      emit(
        SnackBarStateSuccess(
          AppConstants.taskAdded,
        ),
      );
    } else {
      emit(
        SnackBarStateError(
          AppConstants.taskAddFailed,
        ),
      );
    }
  }

  Future<void> _onUpdateTaskEvent(
    UpdateTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    final id = event.task.id;

    final task = TaskInputModel(
      id: id,
      title: event.task.title,
      description: event.task.description,
      date: event.task.date,
      status: event.task.status,
    );
    final result = await _taskUseCase.updateTask(task);

    if (result == id) {
      emit(
        SnackBarStateSuccess(
          AppConstants.taskUpdated,
        ),
      );
    } else {
      emit(
        SnackBarStateError(
          AppConstants.taskUpdateFailed,
        ),
      );
    }
  }
}
