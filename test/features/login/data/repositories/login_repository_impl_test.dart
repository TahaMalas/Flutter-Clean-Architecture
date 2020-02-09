import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_germany/core/error/exceptions.dart';
import 'package:flutter_test_germany/core/error/failures.dart';
import 'package:flutter_test_germany/core/network/network_info.dart';
import 'package:flutter_test_germany/feature/login/data/datasources/login_local_data_source.dart';
import 'package:flutter_test_germany/feature/login/data/datasources/login_remote_data_source.dart';
import 'package:flutter_test_germany/feature/login/data/models/user_model.dart';
import 'package:flutter_test_germany/feature/login/data/repositories/login_repository_impl.dart';
import 'package:flutter_test_germany/feature/login/domain/entities/user.dart';
import 'package:mockito/mockito.dart';

class MockLoginRemoteDataSource extends Mock implements LoginRemoteDataSource {}

class MockLoginLocalDataSource extends Mock implements LoginLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  LoginRepositoryImpl repository;

  MockLoginLocalDataSource mockLoginLocalDataSource;

  MockLoginRemoteDataSource mockLoginRemoteDataSource;

  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockLoginRemoteDataSource = MockLoginRemoteDataSource();
    mockLoginLocalDataSource = MockLoginLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = LoginRepositoryImpl(
      loginRemoteDataSource: mockLoginRemoteDataSource,
      loginLocalDataSource: mockLoginLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('login user', () {
    final tEmail = 'tahamalas@live.com';
    final tPassword = '12345678';
    final tToken = 'asdasdasdasd';
    final tName = 'Taha Malas';
    final tID = 38;

    final tIsRememberMe = true;

    final tFcmToken = 'asdlaksdlkadsklalsdkasdada';

    final tUserModel = UserModel(
      tID,
      tToken,
      tName,
    );

    final tUser = User(
      name: tName,
      token: tToken,
    );

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        await repository.loginUser(tEmail, tPassword, tFcmToken, tIsRememberMe);
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return a User when there is network',
        () async {
          // arrange
          when(mockLoginRemoteDataSource.loginUser(
                  tEmail, tPassword, tFcmToken))
              .thenAnswer((_) async => tUserModel);
          // act
          final user = await repository.loginUser(
              tEmail, tPassword, tFcmToken, tIsRememberMe);
          // assert
          verify(mockLoginRemoteDataSource.loginUser(
              tEmail, tPassword, tFcmToken));
          expect(user, equals(Right(tUser)));
        },
      );

      test(
        '''should save the user\'s data if the isRememberMe flag is TRUE and after
            a successful login''',
        () async {
          // arrange
          when(mockLoginRemoteDataSource.loginUser(
                  tEmail, tPassword, tFcmToken))
              .thenAnswer((_) async => tUserModel);
          // act
          final result = await repository.loginUser(
              tEmail, tPassword, tFcmToken, tIsRememberMe);
          // assert
          verify(mockLoginRemoteDataSource.loginUser(
              tEmail, tPassword, tFcmToken));
          verify(mockLoginLocalDataSource.updateUser(tUserModel, true));
        },
      );

      test(
        'should return ServerFailure when the user is null',
        () async {
          // arrange
          when(mockLoginRemoteDataSource.loginUser(any, any, any))
              .thenAnswer((_) async => null);
          // act
          final user = await repository.loginUser(
              tEmail, tPassword, tFcmToken, tIsRememberMe);
          // assert
          verify(mockLoginRemoteDataSource.loginUser(
              tEmail, tPassword, tFcmToken));
          verifyZeroInteractions(mockLoginLocalDataSource);
          expect(user, equals(Left(ServerFailure())));
        },
      );

      test(
        'should return ServerFailure when an exception thrown',
        () async {
          // arrange
          when(mockLoginRemoteDataSource.loginUser(
                  tEmail, tPassword, tFcmToken))
              .thenThrow(ServerException());
          // act
          final result = await repository.loginUser(
              tEmail, tPassword, tFcmToken, tIsRememberMe);
          // assert
          verify(mockLoginRemoteDataSource.loginUser(
              tEmail, tPassword, tFcmToken));
          verifyZeroInteractions(mockLoginLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should not login the user when there is no network',
        () async {
          // act
          await repository.loginUser(
              tEmail, tPassword, tFcmToken, tIsRememberMe);
          // assert
          verifyZeroInteractions(mockLoginLocalDataSource);
          verifyZeroInteractions(mockLoginRemoteDataSource);
        },
      );

      test(
        'should return ServerFailure when there is no Internet connection',
        () async {
          // act
          final result = await repository.loginUser(
              tEmail, tPassword, tFcmToken, tIsRememberMe);
          // assert
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });
  });
}
