part of 'home_bloc.dart';

sealed class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {
  final bool isShow;

  HomeLoading(
    this.isShow,
  );
}

class HomeSuccess extends HomeState {
  final List<TaskEntity> tasks;

  HomeSuccess(
    this.tasks,
  );
}
