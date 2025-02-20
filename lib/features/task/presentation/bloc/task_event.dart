part of 'task_bloc.dart';

sealed class TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final TaskInputModel task;

  AddTaskEvent(
    this.task,
  );
}

class UpdateTaskEvent extends TaskEvent {
  final TaskInputModel task;

  UpdateTaskEvent(
    this.task,
  );
}
