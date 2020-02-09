import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const <dynamic>[]]) : super(props);
}

class LoginUser extends LoginEvent {
  final String email;
  final String password;
  final bool isRememberMe;
  final String fcmToken;

  LoginUser({
    @required this.email,
    @required this.password,
    @required this.isRememberMe,
    @required this.fcmToken,
  }) : super([email, password, isRememberMe, fcmToken]);

  @override
  String toString() {
    return '$email, $password, $isRememberMe, $fcmToken';
  }
}

class ForgotPasswordEvent extends LoginEvent {
  final String number;

  ForgotPasswordEvent(this.number) : super([number]);
}

class ChangeEmail extends LoginEvent {
  final String newEmail;

  ChangeEmail(this.newEmail) : super([newEmail]);
}

class ResetSuccess extends LoginEvent {}

class ChangePassword extends LoginEvent {
  final String newPassword;

  ChangePassword(this.newPassword) : super([newPassword]);
}

class ChangeIsRememberMe extends LoginEvent {
  ChangeIsRememberMe() : super();
}

class ChangeForgotPasswordNumber extends LoginEvent {
  final String newNumber;

  ChangeForgotPasswordNumber(this.newNumber) : super([newNumber]);
}
