import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:technical_assessment_task/features/Authentication/presentation/screen/widgets/Custom_headline_Text.dart';

class LoginText extends StatelessWidget {
  const LoginText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          text: "You have an account?",
          size: 18,
          fontWeight: FontWeight.w500,
        ),
        GestureDetector(
          onTap: () {
            context.pushReplacement('/login');
          },
          child: CustomText(
            text: "login",
            size: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
