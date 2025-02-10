import 'package:task_management/features/login/data/model/login_model.dart';
import 'package:task_management/network/dio_client.dart';
import 'package:task_management/network/network_constants.dart';

abstract class LoginDataSource {
  Future<LoginModel> login(
    String email,
    String password,
  );
}

class LoginDataSourceImpl implements LoginDataSource {
  final DioClient _dioClient;

  LoginDataSourceImpl(
    this._dioClient,
  );

  @override
  Future<LoginModel> login(
    String email,
    String password,
  ) async {
    try {
      final response = await _dioClient.get(
        '${NetworkConstants.login}/$email',
      );

      final loginModel = LoginModel.fromJson(response.data);

      return loginModel;
    } catch (_) {
      rethrow;
    }
  }
}
