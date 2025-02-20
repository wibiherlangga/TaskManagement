import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:task_management/config/routes/app_routes.dart';
import 'package:task_management/config/theme/app_theme.dart';
import 'package:task_management/core/constants/app_constants.dart';
import 'package:task_management/features/login/presentation/pages/login_page.dart';
import 'package:task_management/injector.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await initDepedencies();
  await initializeDateFormatting('id_ID', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.taskManagement,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: LoginPage.id,
      onGenerateRoute: (settings) => AppRoutes.onGenerateRoute(settings),
    );
  }
}
