import 'package:dartz/dartz.dart';
import 'package:technical_assessment_task/core/errors/failure.dart';
import 'package:technical_assessment_task/features/Authentication/data/model/auth_model.dart';

abstract class AuthRepo {
 Future<Either<Failure ,AuthModel>> signup({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, AuthModel>> signin({
    required String email,
    required String password,
  });
}
