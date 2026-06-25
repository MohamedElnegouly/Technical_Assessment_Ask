
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:technical_assessment_task/core/routers/app_routers.dart';
import 'package:technical_assessment_task/core/theme/app_theme.dart';
import 'package:technical_assessment_task/core/theme/theme_cubit.dart';
import 'package:technical_assessment_task/core/utils/service_locator.dart';
import 'package:technical_assessment_task/features/Authentication/data/model/auth_model.dart';
import 'package:technical_assessment_task/features/Authentication/presentation/manager/cubit/cubit/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Hive.initFlutter();
    Hive.registerAdapter(AuthModelAdapter());
    Hive.registerAdapter(UserModelAdapter());
    await Hive.openBox<AuthModel>('userBox');
    await Hive.openBox('authBox');
    await Hive.openBox('settingsBox');
    await Hive.openBox('cacheBox');
    setupServiceLocator();
  } catch (e) {
    debugPrint('ERROR: $e');
  }
  
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
         BlocProvider<AuthCubit>(
          create: (_) => getIt<AuthCubit>(),
        ),
        BlocProvider<ThemeCubit>(
          create: (_) => getIt<ThemeCubit>(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeMode,
            routerConfig: AppRouters.router,
          );
        },
      ),
    );
  }
}
