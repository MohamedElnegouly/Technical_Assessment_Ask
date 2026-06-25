import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:technical_assessment_task/core/theme/theme_cubit.dart';
import 'package:technical_assessment_task/core/utils/Api_service.dart';
import 'package:technical_assessment_task/core/utils/cache_service.dart';
import 'package:technical_assessment_task/features/Authentication/data/repo/auth_repo.dart';
import 'package:technical_assessment_task/features/Authentication/data/repo/auth_repo_impl.dart';
import 'package:technical_assessment_task/features/Authentication/presentation/manager/cubit/cubit/auth_cubit.dart';
import 'package:technical_assessment_task/features/Projects/data/repo/projects_repo.dart';
import 'package:technical_assessment_task/features/Projects/data/repo/projects_repo_impl.dart';
import 'package:technical_assessment_task/features/Projects/presentation/manager/cubit/projects_cubit.dart';
import 'package:technical_assessment_task/features/Projects/presentation/manager/cubit/tasks_cubit.dart';

final getIt = GetIt.instance;
void setupServiceLocator() {
  getIt.registerSingleton<ApiService>(ApiService(Dio()));
  getIt.registerSingleton<CacheService>(CacheService());
  getIt.registerSingleton<ThemeCubit>(ThemeCubit());

  getIt.registerSingleton<AuthRepo>(AuthRepoImpl(getIt.get<ApiService>()));
  getIt.registerFactory(() => AuthCubit(getIt.get<AuthRepo>()));

  getIt.registerSingleton<ProjectsRepo>(
    ProjectsRepoImpl(getIt.get<ApiService>(), getIt.get<CacheService>()),
  );
  getIt.registerFactory(() => ProjectsCubit(getIt.get<ProjectsRepo>()));
  getIt.registerFactory(() => TasksCubit(getIt.get<ProjectsRepo>()));
}
