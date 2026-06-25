import 'package:flutter/material.dart';
import 'package:technical_assessment_task/core/utils/app_colors.dart';

class CustomText extends StatelessWidget {
  final String text;
  final int size;
  final FontWeight? fontWeight;
  final Color? color;
  const CustomText({
    super.key,
    required this.text,
    required this.size,
    this.fontWeight,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign:TextAlign.start,
      style: TextStyle(
        color : color ?? AppColors.darkBlue,
        fontSize: size.toDouble(),
        fontFamily: 'Poppins',
        fontWeight: fontWeight ?? FontWeight.w600,
        height: 1,
        letterSpacing: -0.17,
      ),
    );
  }
}
