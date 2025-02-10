import 'package:fpdart/fpdart.dart';
import 'package:task_management/features/login/domain/entity/login_entity.dart';
import 'package:task_management/network/network_exception.dart';

abstract class LoginRepository {
  Future<Either<NetworkException, LoginEntity>> login(
    String email,
    String password,
  );
}
