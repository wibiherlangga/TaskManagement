import 'package:flutter_dotenv/flutter_dotenv.dart';

class NetworkConstants {
  final baseUrl = '${dotenv.env['BASE_URL']}';
}
