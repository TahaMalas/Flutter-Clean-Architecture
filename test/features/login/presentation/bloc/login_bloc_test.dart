import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test/flutter_test.dart' as prefix0;
import 'package:flutter_test_germany/core/util/input_validator.dart';
import 'package:flutter_test_germany/feature/login/domain/usecases/login.dart';
import 'package:flutter_test_germany/feature/login/presentation/bloc/login_bloc.dart';
import 'package:flutter_test_germany/feature/login/presentation/bloc/login_state.dart';
import 'package:mockito/mockito.dart';

class MockLogin extends Mock implements Login {}

class MockInputValidator extends Mock implements InputValidator {}

void main() {
  LoginBloc bloc;

  MockLogin mockLogin;

  MockInputValidator mockInputValidator;

  setUp(() {
    mockLogin = MockLogin();
    mockInputValidator = MockInputValidator();
    bloc = LoginBloc(
      login: mockLogin,
      inputValidator: mockInputValidator,
    );
  });

  test('initialState should be Empty', () {
    // assert
    expect(bloc.initialState, equals(LoginState.initial()));
  });

  final tEmail = 'tahamalas@live.com';
  final tPassword = '12345678';

  group('change password', () {
    void setUpMockInputValidatorSuccess() =>
        when(mockInputValidator.checkPassword(any))
            .thenReturn(Right(tPassword));

    test(
      'should call the InputValidator to validate the password',
      () async {
        // arrange
        setUpMockInputValidatorSuccess();
        // act
        bloc.changePassword(tPassword);
        await untilCalled(mockInputValidator.checkPassword(any));
        // assert
        verify(mockInputValidator.checkPassword(tPassword));
      },
    );

    test(
      'should return the password when the password is valid',
      () async {
        // arrange
        setUpMockInputValidatorSuccess();
        final expected = [
          LoginState.initial(),
          LoginState.noPasswordError(LoginState.initial()),
        ];
        // assert later
        expectLater(bloc.state, emitsInOrder(expected));
        // act
        bloc.changePassword(tPassword);
      },
    );

    test(
      'should emit [Error] when the password is invalid',
      () async {
        // arrange
        when(mockInputValidator.checkPassword(any))
            .thenReturn(Left(InvalidInputFailure()));
        // assert later
        final expected = [
          LoginState.initial(),
          LoginState.passwordError(LoginState.initial()),
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        // act
        bloc.changePassword(tPassword);
      },
    );
  });

  group('change email', () {
    void setUpMockInputValidatorSuccess() =>
        when(mockInputValidator.checkEmail(any)).thenReturn(Right(tEmail));

    test(
      'should call the InputValidator to validate the email',
      () async {
        // arrange
        setUpMockInputValidatorSuccess();
        // act
        bloc.changeEmail(tEmail);
        await untilCalled(mockInputValidator.checkEmail(any));
        // assert
        verify(mockInputValidator.checkEmail(tEmail));
      },
    );

    test(
      'should return the email when the email is valid',
      () async {
        // arrange
        setUpMockInputValidatorSuccess();
        // assert later
        final expected = [
          LoginState.initial(),
          LoginState.noEmailError(LoginState.initial()),
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        // act
        bloc.changeEmail(tEmail);
      },
    );

    test(
      'should emit [Error] when the email is invalid',
      () async {
        // arrange
        when(mockInputValidator.checkEmail(any))
            .thenReturn(Left(InvalidInputFailure()));
        // assert later
        final expected = [
          LoginState.initial(),
          LoginState.emailError(LoginState.initial()),
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        // act
        bloc.changeEmail(tEmail);
      },
    );
  });
}
