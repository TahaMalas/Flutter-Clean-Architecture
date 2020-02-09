import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_germany/core/error/failures.dart';
import 'package:flutter_test_germany/core/network/network_info.dart';

typedef FutureEitherOr<T> = Future<Either<Failure, T>> Function();
typedef FutureEitherOrWithToken<T> = Future<Either<Failure, T>> Function(
    String token);

abstract class BaseRepository {
  Future<Either<Failure, T>> checkNetwork<T>(FutureEitherOr<T> body);
}

class BaseRepositoryImpl implements BaseRepository {
  final NetworkInfo networkInfo;

  BaseRepositoryImpl({@required this.networkInfo});

  @override
  Future<Either<Failure, T>> checkNetwork<T>(FutureEitherOr<T> body) async {
    if (await networkInfo.isConnected) {
      return body();
    } else {
      return Left(ServerFailure());
    }
  }
}
