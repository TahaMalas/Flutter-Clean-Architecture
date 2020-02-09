import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test_germany/core/error/failures.dart';
import 'package:flutter_test_germany/core/util/constants.dart';
import 'package:flutter_test_germany/core/util/input_validator.dart';
import 'package:flutter_test_germany/feature/login/domain/entities/user.dart';
import 'package:flutter_test_germany/feature/login/domain/usecases/login.dart';
import 'package:flutter_test_germany/feature/login/presentation/bloc/login_event.dart';
import 'package:flutter_test_germany/feature/login/presentation/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  String email;

  String forgotPasswordNumber;

  String password;

  bool isRememberMe = true;

  final Login loginUseCase;

  final InputValidator inputValidator;

  void changeEmail(String email) {
    dispatch(ChangeEmail(email));
  }

  void triggerRememberMe() {
    dispatch(ChangeIsRememberMe());
  }

  void changePassword(String password) {
    dispatch(ChangePassword(password));
  }

  void changeForgotPasswordNumber(String number) {
    dispatch(ChangeForgotPasswordNumber(number));
  }

  void resetSuccess() {
    dispatch(ResetSuccess());
  }

  void onLoginPressed(String fcmToken) {
    dispatch(LoginUser(
      email: email,
      password: password,
      isRememberMe: isRememberMe,
      fcmToken: fcmToken,
    ));
  }

  LoginBloc({
    @required Login login,
    @required this.inputValidator,
  })  : assert(login != null),
        assert(inputValidator != null),
        loginUseCase = login;

  @override
  LoginState get initialState => LoginState.initial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    print('$event');
    if (event is ChangeEmail) {
      yield* _checkEmail(event.newEmail);
    } else if (event is ChangePassword) {
      yield* _checkPassword(event.newPassword);
    } else if (event is LoginUser) {
      _checkEmail(event.email);
      _checkPassword(event.password);
      yield LoginState.loading(currentState);
      final user = await loginUseCase(
        LoginParams(
          email: event.email,
          password: event.password,
          fcmToken: event.fcmToken,
          isRememberMe: event.isRememberMe,
        ),
      );
      yield* _eitherLoadedOrErrorState(user);
    } else if (event is ChangeIsRememberMe) {
      isRememberMe = !currentState.isRememberMe;
      yield currentState.rebuild((b) => b..isRememberMe = !b.isRememberMe);
    } else if (event is ResetSuccess) {
      yield currentState.rebuild((b) => b..isSuccess = false);
    }
  }

  Stream<LoginState> _eitherLoadedOrErrorState(
    Either<Failure, User> failureOrTrivia,
  ) async* {
    yield failureOrTrivia.fold(
      (failure) =>
          LoginState.loginError(currentState, _mapFailureToMessage(failure)),
      (trivia) => LoginState.success(currentState),
    );
  }

  int _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 3;
    }
  }

  Stream<LoginState> _checkEmail(String email) async* {
    print('number is $email');
    final inputEither = inputValidator.checkEmail(email);
    yield* inputEither.fold(
      (failure) async* {
        print('failure is $failure');
        yield LoginState.emailError(currentState);
      },
      (phoneNumber) async* {
        this.email = email;
        yield LoginState.noEmailError(currentState);
      },
    );
  }

  Stream<LoginState> _checkPassword(String password) async* {
    final inputEither = inputValidator.checkPassword(password);
    yield* inputEither.fold(
      (failure) async* {
        yield LoginState.passwordError(currentState);
      },
      (phoneNumber) async* {
        this.password = password;
        yield LoginState.noPasswordError(currentState);
      },
    );
  }
}
