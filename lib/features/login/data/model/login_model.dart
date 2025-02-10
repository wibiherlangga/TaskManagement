import 'package:json_annotation/json_annotation.dart';
import 'package:task_management/core/mixin/entity_convertible_mixin.dart';
import 'package:task_management/features/login/domain/entity/login_entity.dart';

part 'login_model.g.dart';

@JsonSerializable(createFactory: true)
class LoginModel with EntityConvertibleMixin {
  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'password')
  final String password;

  const LoginModel(
    this.email,
    this.password,
  );

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  @override
  LoginEntity toEntity() {
    return const LoginEntity(true);
  }
}
