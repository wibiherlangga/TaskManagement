import 'package:flutter_dotenv/flutter_dotenv.dart';

class NetworkConstants {
  static final baseUrl = '${dotenv.env['BASE_URL']}';
  static final login = '$baseUrl/login';
}
