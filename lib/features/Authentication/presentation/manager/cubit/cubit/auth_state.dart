part of 'auth_cubit.dart';


abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}
class AuthLogout extends AuthState {}
class AuthAccountDeleted extends AuthState {}
class AuthSuccess extends AuthState {
  final AuthModel response;
  AuthSuccess(this.response);
}

class AuthFailure extends AuthState {
  final String errorMessage;
  AuthFailure(this.errorMessage);
}