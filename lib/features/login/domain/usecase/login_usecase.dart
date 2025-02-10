import 'package:fpdart/fpdart.dart';
import 'package:task_management/features/login/domain/entity/login_entity.dart';
import 'package:task_management/features/login/domain/repository/login_repository.dart';
import 'package:task_management/network/network_exception.dart';

class LoginUseCase {
  final LoginRepository _loginRepository;

  const LoginUseCase(
    this._loginRepository,
  );

  Future<Either<NetworkException, LoginEntity>> login(
    String email,
    String password,
  ) async {
    return await _loginRepository.login(email, password);
  }
}
