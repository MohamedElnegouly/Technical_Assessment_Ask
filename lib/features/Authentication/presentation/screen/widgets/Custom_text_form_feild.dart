
import 'package:flutter/material.dart';
import 'package:technical_assessment_task/core/utils/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final Key? fieldKey;
  final void Function(String)? onChanged;
  final void Function(String?)? onsaved;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final TextEditingController controller;
  const CustomTextFormField({
    super.key,
    this.fieldKey,
    this.onChanged,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.obscureText,
    this.onsaved, required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: fieldKey,
      controller: controller,
      cursorColor: AppColors.darkBlue,
      cursorWidth: 2,
      cursorHeight: 22,
      onChanged: onChanged,
      onSaved: onsaved,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field cannot be empty';
        } else {
          return null;
        }
      },
      obscureText: obscureText ?? false,
      style: const TextStyle(
        color: AppColors.darkBlue,
        fontSize: 17,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.primary.withValues(alpha: 0.7),
          fontSize: 17,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          height: 1,
          letterSpacing: -0.17,
        ),

        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: borderDecoration(AppColors.primary.withValues(alpha: 0.3)),
        focusedBorder: borderDecoration(AppColors.primary),
        enabledBorder: borderDecoration(AppColors.primary.withValues(alpha: 0.3)),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 16,
        ),
      ),
      keyboardType: keyboardType,
    );
  }

  OutlineInputBorder borderDecoration(Color color) => OutlineInputBorder(
    borderSide: BorderSide(
      width: 1,
      strokeAlign: BorderSide.strokeAlignCenter,
      color: color,
    ),
    borderRadius: BorderRadius.circular(15),
  );
}
