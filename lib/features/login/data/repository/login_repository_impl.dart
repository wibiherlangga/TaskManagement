import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:task_management/features/login/data/data_source/remote/login_data_source.dart';
import 'package:task_management/features/login/domain/entity/login_entity.dart';
import 'package:task_management/features/login/domain/repository/login_repository.dart';
import 'package:task_management/network/network_exception.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSource _loginDataSource;

  LoginRepositoryImpl(
    this._loginDataSource,
  );

  @override
  Future<Either<NetworkException, LoginEntity>> login(
    String email,
    String password,
  ) async {
    try {
      final result = await _loginDataSource.login(
        email,
        password,
      );

      final loginStatus = result.toEntity();

      return Right(loginStatus);
    } on DioException catch (e) {
      return left(NetworkException.fromDioError(e));
    }
  }
}
