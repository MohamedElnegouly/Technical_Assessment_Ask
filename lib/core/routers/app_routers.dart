import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:technical_assessment_task/core/utils/app_routers_strings.dart';
import 'package:technical_assessment_task/features/Authentication/presentation/screen/login_screen.dart';
import 'package:technical_assessment_task/features/Authentication/presentation/screen/register_screen.dart';
import 'package:technical_assessment_task/features/Home/presentation/screens/home.dart';


class AppRouters {
  static final router = GoRouter(
    initialLocation: Hive.box('authBox').get('token') != null
        ? AppRoutersStrings.home
        : AppRoutersStrings.login,
    redirect: (context, state) {
      final token = Hive.box('authBox').get('token');
      final isOnLogin = state.matchedLocation == AppRoutersStrings.login;
      final isOnRegister = state.matchedLocation == AppRoutersStrings.register;

      // لو مسجل دخول وبيحاول يروح Login أو Register → وديه Home
      if (token != null && (isOnLogin || isOnRegister)) {
        return AppRoutersStrings.home;
      }

      // لو مش مسجل وبيحاول يروح Home → وديه Login
      if (token == null && !isOnLogin && !isOnRegister) {
        return AppRoutersStrings.login;
      }

      return null; // خليه يكمل عادي
    },
    routes: [
      GoRoute(
        path: AppRoutersStrings.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutersStrings.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutersStrings.home,
        builder: (context, state) => const Home(),
      ),
    ],
  );
}