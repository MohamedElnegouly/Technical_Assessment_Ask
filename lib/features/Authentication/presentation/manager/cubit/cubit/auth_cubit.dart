import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:technical_assessment_task/core/errors/failure.dart';
import 'package:technical_assessment_task/features/Authentication/data/model/auth_model.dart';
import 'package:technical_assessment_task/features/Authentication/data/repo/auth_repo.dart';
part 'auth_state.dart';


class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AuthCubit(this.authRepo) : super(AuthInitial());

  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    final Either<Failure, AuthModel> result = await authRepo.signup(
      name: name,
      email: email,
      password: password,
    );

    result.fold(
      (failure) => emit(AuthFailure(failure.errMessage)),
      (response) async {
        final box = Hive.box<AuthModel>('userBox');
        await box.put('user', response);
        emit(AuthSuccess(response));
      },
    );
  }

  Future<void> signin({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    final Either<Failure, AuthModel> result = await authRepo.signin(
      email: email,
      password: password,
    );

    result.fold(
      (failure) => emit(AuthFailure(failure.errMessage)),
      (response) async {
        final box = Hive.box<AuthModel>('userBox');
        await box.put('user', response);
        emit(AuthSuccess(response));
      },
    );
  }
   
   Future<void> clearUserData() async {
    final userBox = Hive.box<AuthModel>('userBox');
    await userBox.clear();
    final authBox = Hive.box('authBox');
    await authBox.delete('token');
  }

 Future<void> logout(BuildContext context) async {
    emit(AuthLoading());
    await clearUserData();
    emit(AuthLogout());
    if (context.mounted) context.go('/login');
  }

 Future<void> deleteAccount(BuildContext context) async {
    emit(AuthLoading());
    try {
      // Api call to delete account from server here
      await clearUserData();
      emit(AuthAccountDeleted());
      //make sure the context is still mounted before navigating
      if (context.mounted) context.go('/login');
    } catch (e) {
      emit(AuthFailure("Failed to delete account: ${e.toString()}"));
    }
  }
}