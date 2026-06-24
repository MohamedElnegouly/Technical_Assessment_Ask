import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:technical_assessment_task/core/utils/Api_service.dart';
import 'package:technical_assessment_task/features/Authentication/data/repo/auth_repo.dart';
import 'package:technical_assessment_task/features/Authentication/data/repo/auth_repo_impl.dart';
import 'package:technical_assessment_task/features/Authentication/presentation/manager/cubit/cubit/auth_cubit.dart';

final getIt = GetIt.instance;
void setupServiceLocator() {
  getIt.registerSingleton<ApiService>(ApiService(Dio()));
  getIt.registerSingleton<AuthRepo>(AuthRepoImpl(getIt.get<ApiService>()));
  getIt.registerFactory(() => AuthCubit(getIt.get<AuthRepo>()));

}

