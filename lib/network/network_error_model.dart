import 'package:json_annotation/json_annotation.dart';

part 'network_error_model.g.dart';

@JsonSerializable()
class NetworkErrorModel {
  @JsonKey(name: 'status_code')
  final int? statusCode;

  @JsonKey(name: 'status_message')
  final String? statusMessage;

  const NetworkErrorModel({
    this.statusCode,
    this.statusMessage,
  });

  factory NetworkErrorModel.fromJson(Map<String, dynamic> json) {
    return _$NetworkErrorModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NetworkErrorModelToJson(this);
}
