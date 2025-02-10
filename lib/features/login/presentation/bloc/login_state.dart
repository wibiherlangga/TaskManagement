part of 'login_bloc.dart';

abstract class LoginState {}

final class LoginInitial extends LoginState {}

class SnackBarStateNone extends LoginState {}

class SnackBarStateError extends LoginState {
  final String message;
  SnackBarStateError(
    this.message,
  );
}

class SnackBarStateSuccess extends LoginState {
  final String message;

  SnackBarStateSuccess(
    this.message,
  );
}
