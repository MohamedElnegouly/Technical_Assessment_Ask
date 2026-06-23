import 'package:flutter/material.dart';
import 'package:technical_assessment_task/login_page.dart';

void main() {
  runApp(const TECHNICALASSTASK());
}

class TECHNICALASSTASK extends StatelessWidget {
  const TECHNICALASSTASK({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const LoginPage());
  }
}
