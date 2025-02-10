import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/features/login/domain/usecase/login_usecase.dart';
import 'package:task_management/network/network_exception.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc(
    this.loginUseCase,
  ) : super(LoginInitial()) {
    on<LoginUser>(_onLoginUser);
  }

  Future<void> _onLoginUser(LoginUser event, Emitter<LoginState> emit) async {
    final result = await loginUseCase.login(
      event.email,
      event.password,
    );

    result.fold(
      (l) => _handleLoginError(
        l,
        emit,
      ),
      (r) => _handleLoginUser(
        event.email,
        emit,
      ),
    );
  }

  Future<void> _handleLoginUser(
    String email,
    Emitter<LoginState> emit,
  ) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString('email', email);
    emit(SnackBarStateSuccess('login successfully!'));
  }

  void _handleLoginError(NetworkException error, Emitter<LoginState> emit) {
    if (error.statusCode == 404) {
      emit(
        SnackBarStateError('email or password is incorrect'),
      );
    } else {
      emit(
        SnackBarStateError(
          error.message,
        ),
      );
    }
  }
}
