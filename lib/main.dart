
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:technical_assessment_task/core/routers/app_routers.dart';
import 'package:technical_assessment_task/core/utils/service_locator.dart';
import 'package:technical_assessment_task/features/Authentication/data/model/auth_model.dart';
import 'package:technical_assessment_task/features/Authentication/presentation/manager/cubit/cubit/auth_cubit.dart';

void main() async {
  // ✅ تأكد إن Flutter جاهز لتحميل أي async dependencies
  WidgetsFlutterBinding.ensureInitialized();
   // ✅ init Hive
  await Hive.initFlutter();

  // ✅ register adapters
  Hive.registerAdapter(AuthModelAdapter());
  Hive.registerAdapter(UserModelAdapter());

  // ✅ open user box
  await Hive.openBox<AuthModel>('userBox');

  setupServiceLocator();
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

      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouters.router,
      ),
    );
  }
}
