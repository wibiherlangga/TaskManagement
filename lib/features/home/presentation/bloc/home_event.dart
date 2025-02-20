part of 'home_bloc.dart';

sealed class HomeEvent {}

class GetTaskEvent extends HomeEvent {}

class DeleteTaskEvent extends HomeEvent {
  final int id;
  final List<TaskEntity> tasks;

  DeleteTaskEvent(
    this.id,
    this.tasks,
  );
}
