import 'package:flutter/material.dart';
import 'package:technical_assessment_task/features/Authentication/presentation/screen/widgets/login_body_view.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginBodyView(),
    );
  }
}
