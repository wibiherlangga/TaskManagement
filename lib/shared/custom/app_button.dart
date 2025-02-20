import 'package:flutter/material.dart';
import 'package:task_management/config/colors/app_colors.dart';
import 'package:task_management/config/theme/app_theme_text_style.dart';

class AppButton extends StatelessWidget {
  final String title;
  final Function() onPressed;
  const AppButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        fixedSize: const Size(double.infinity, 52),
        elevation: 8,
      ),
      child: Text(
        title,
        style: AppThemeTextStyle.museoSans700.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}
