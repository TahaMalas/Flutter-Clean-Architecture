import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test_germany/core/data/base_repository.dart';
import 'package:flutter_test_germany/core/error/exceptions.dart';
import 'package:flutter_test_germany/core/error/failures.dart';
import 'package:flutter_test_germany/core/network/network_info.dart';
import 'package:flutter_test_germany/feature/login/data/datasources/login_local_data_source.dart';
import 'package:flutter_test_germany/feature/login/data/datasources/login_remote_data_source.dart';
import 'package:flutter_test_germany/feature/login/domain/entities/user.dart';
import 'package:flutter_test_germany/feature/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl extends BaseRepositoryImpl
    implements LoginRepository {
  final LoginRemoteDataSource loginRemoteDataSource;
  final LoginLocalDataSource loginLocalDataSource;
  final NetworkInfo networkInfo;

  LoginRepositoryImpl({
    @required this.loginRemoteDataSource,
    @required this.loginLocalDataSource,
    @required this.networkInfo,
  }) : super(networkInfo: networkInfo);

  @override
  Future<Either<Failure, User>> loginUser(
      String email, String password, String fcmToken, bool isRememberMe) async {
    return await checkNetwork<User>(
      () async {
        try {
          final userModel =
              await loginRemoteDataSource.loginUser(email, password, fcmToken);
          print('user mdoel ${userModel.name}');
          if (userModel != null) {
            await loginLocalDataSource.updateUser(userModel, isRememberMe);
            return Right(userModel);
          }
          return Left(ServerFailure());
        } on ServerException catch (e) {
          print('e is $e');
          return Left(ServerFailure());
        }
      },
    );
  }
}
