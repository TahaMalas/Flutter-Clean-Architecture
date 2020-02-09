library login_state;

import 'package:built_value/built_value.dart';
import 'package:flutter_test_germany/core/util/constants.dart';

part 'login_state.g.dart';

abstract class LoginState implements Built<LoginState, LoginStateBuilder> {
  String get password;

  String get number;

  bool get isRememberMe;

  String get forgotPasswordNumber;

  int get error;

  int get forgotPasswordError;

  bool get isPasswordError;

  bool get isEmailError;

  bool get isLoading;

  bool get isSuccess;

  bool get isInitial;

  bool get isEnabled => !isPasswordError && !isEmailError && !isInitial;

  LoginState._();

  factory LoginState([updates(LoginStateBuilder b)]) = _$LoginState;

  factory LoginState.initial() {
    return LoginState((b) => b
      ..password = ''
      ..number = ''
      ..forgotPasswordNumber = ''
      ..error = LoginTexts.NO_ERROR
      ..forgotPasswordError = LoginTexts.NO_ERROR
      ..isLoading = false
      ..isSuccess = false
      ..isRememberMe = true
      ..isInitial = true
      ..isEmailError = false
      ..isPasswordError = false);
  }

  factory LoginState.loading(LoginState currentState) {
    return currentState.rebuild((b) => b
      ..isLoading = true
      ..isInitial = false);
  }

  factory LoginState.success(LoginState currentState) {
    return currentState.rebuild((b) => b
      ..isInitial = false
      ..isLoading = false
      ..isSuccess = true);
  }

  factory LoginState.loginError(LoginState currentState, int error) {
    return currentState.rebuild((b) => b
      ..isInitial = false
      ..error = error
      ..isLoading = false
      ..isSuccess = false);
  }

  factory LoginState.passwordError(LoginState currentState) {
    return currentState.rebuild((b) => b
      ..isPasswordError = true
      ..isInitial = false);
  }

  factory LoginState.noPasswordError(LoginState currentState) {
    return currentState.rebuild((b) => b
      ..isPasswordError = false
      ..isInitial = false);
  }

  factory LoginState.emailError(LoginState currentState) {
    return currentState.rebuild((b) => b
      ..isEmailError = true
      ..isInitial = false);
  }

  factory LoginState.noEmailError(LoginState currentState) {
    return currentState.rebuild((b) => b
      ..isEmailError = false
      ..isInitial = false);
  }
}
