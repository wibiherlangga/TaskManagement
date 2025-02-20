import 'package:flutter/material.dart';
import 'package:task_management/features/home/presentation/page/home_page.dart';
import 'package:task_management/features/login/presentation/pages/login_page.dart';
import 'package:task_management/features/task/presentation/page/task_page.dart';
import 'package:task_management/shared/model/task_entity.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginPage.id:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case HomePage.id:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case TaskPage.id:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => TaskPage(
            task: args['task'] as TaskEntity?,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('404 Not Found'),
            ),
          ),
        );
    }
  }
}
