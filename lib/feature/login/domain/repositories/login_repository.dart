import 'package:dartz/dartz.dart';
import 'package:flutter_test_germany/core/data/base_repository.dart';
import 'package:flutter_test_germany/core/error/failures.dart';
import 'package:flutter_test_germany/feature/login/domain/entities/user.dart';

abstract class LoginRepository extends BaseRepository {
  Future<Either<Failure, User>> loginUser(
      String email,
      String password,
      String fcmToken,
      bool isRememberMe,
      );

}
