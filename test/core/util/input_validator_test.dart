import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_germany/core/util/input_validator.dart';

void main() {
  InputValidator inputValidator;

  setUp(() {
    inputValidator = InputValidator();
  });

  group('check password', () {
    test(
      'should return the password when the string represents a valid password',
      () async {
        // arrange
        final tPassword = '12345678';
        // act
        final result = inputValidator.checkPassword(tPassword);
        // assert
        expect(result, Right(tPassword));
      },
    );

    test(
      'should return a Failure when the string is not a valid password',
      () async {
        // arrange
        final tPassword = '1234567';
        // act
        final result = inputValidator.checkPassword(tPassword);
        // assert
        expect(result, Left(InvalidInputFailure()));
      },
    );
  });

  group('check email', () {
    test(
      'should return the same number when the string represents a valid phone number',
      () async {
        // arrange
        final str = 'tahamalas@live.com';
        // act
        final result = inputValidator.checkEmail(str);
        // assert
        expect(result, Right('tahamalas@live.com'));
      },
    );

    test(
      'should return a Failure when the string is a word',
      () async {
        // arrange
        final str = 'abc';
        // act
        final result = inputValidator.checkEmail(str);
        // assert
        expect(result, Left(InvalidInputFailure()));
      },
    );

    test(
      'should return a Failure when the string is not a valid phone number',
      () async {
        // arrange
        final str = '5867606609';
        // act
        final result = inputValidator.checkEmail(str);
        // assert
        expect(result, Left(InvalidInputFailure()));
      },
    );
  });
}
