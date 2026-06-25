import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:technical_assessment_task/core/utils/app_routers_strings.dart';
import 'package:technical_assessment_task/core/utils/service_locator.dart';
import 'package:technical_assessment_task/features/Authentication/presentation/screen/login_screen.dart';
import 'package:technical_assessment_task/features/Authentication/presentation/screen/register_screen.dart';
import 'package:technical_assessment_task/features/Profile/presentation/screens/profile_screen.dart';
import 'package:technical_assessment_task/features/Projects/presentation/manager/cubit/projects_cubit.dart';
import 'package:technical_assessment_task/features/Projects/presentation/manager/cubit/tasks_cubit.dart';
import 'package:technical_assessment_task/features/Projects/presentation/screens/project_details_screen.dart';
import 'package:technical_assessment_task/features/Projects/presentation/screens/projects_screen.dart';

CustomTransitionPage<void> _slideTransitionPage({
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
        child: FadeTransition(opacity: animation, child: child),
      );
    },
  );
}

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
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<ProjectsCubit>(),
          child: const ProjectsScreen(),
        ),
      ),
      GoRoute(
        path: '${AppRoutersStrings.projectDetails}/:id',
        pageBuilder: (context, state) => _slideTransitionPage(
          state: state,
          child: BlocProvider(
            create: (_) => getIt<TasksCubit>(),
            child: ProjectDetailsScreen(
              projectId: state.pathParameters['id']!,
              projectTitle: state.extra as String?,
            ),
          ),
        ),
      ),
      GoRoute(
        path: AppRoutersStrings.profile,
        pageBuilder: (context, state) => _slideTransitionPage(
          state: state,
          child: const ProfileScreen(),
        ),
      ),
    ],
  );
}
