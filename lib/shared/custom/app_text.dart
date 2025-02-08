import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String title;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final int? maxLines;
  final TextOverflow? overflow;

  const AppText({
    super.key,
    required this.title,
    required this.color,
    required this.fontSize,
    required this.fontWeight,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: color,
        fontFamily: 'Poppins',
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
