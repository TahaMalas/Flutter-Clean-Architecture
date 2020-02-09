import 'package:dartz/dartz.dart';
import 'package:flutter_test_germany/core/error/failures.dart';

typedef EitherOr<T> = Either<Failure, T> Function(String);

class InputValidator {
  Either<Failure, String> checkPassword(String password) {
    try {
      if (password.length < 8) throw FormatException();
      return Right(password);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }

  Either<Failure, String> checkEmail(String email) {
    try {
      if (email.length > 3 && email.contains('@') && email.contains('.'))
        return Right(email);
      throw FormatException();
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}
