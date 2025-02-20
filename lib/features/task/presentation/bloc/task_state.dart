part of 'task_bloc.dart';

sealed class TaskState {}

class SnackBarStateNone extends TaskState {}

class SnackBarStateError extends TaskState {
  final String message;
  SnackBarStateError(
    this.message,
  );
}

class SnackBarStateSuccess extends TaskState {
  final String message;

  SnackBarStateSuccess(
    this.message,
  );
}
