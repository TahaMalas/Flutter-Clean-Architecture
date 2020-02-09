import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_germany/core/error/failures.dart';
import 'package:flutter_test_germany/core/usecases/usecase.dart';
import 'package:flutter_test_germany/feature/login/domain/entities/user.dart';
import 'package:flutter_test_germany/feature/login/domain/repositories/login_repository.dart';

class Login extends UseCase<User, LoginParams> {
  final LoginRepository repository;

  Login({@required this.repository}) : assert(repository != null);

  @override
  Future<Either<Failure, User>> call(params) async {
    return await repository.loginUser(
        params.email, params.password, params.fcmToken, params.isRememberMe);
  }
}

class LoginParams extends Equatable {
  final String email;

  final String password;

  final String fcmToken;

  final bool isRememberMe;

  LoginParams({
    @required this.email,
    @required this.password,
    @required this.fcmToken,
    @required this.isRememberMe,
  }) : super([email, password, fcmToken, isRememberMe]);
}
