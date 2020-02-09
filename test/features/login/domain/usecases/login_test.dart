import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_germany/core/error/failures.dart';
import 'package:flutter_test_germany/feature/login/domain/entities/user.dart';
import 'package:flutter_test_germany/feature/login/domain/repositories/login_repository.dart';
import 'package:flutter_test_germany/feature/login/domain/usecases/login.dart';
import 'package:mockito/mockito.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  MockLoginRepository mockLoginRepository;

  Login useCase;

  setUp(() {
    mockLoginRepository = MockLoginRepository();
    useCase = Login(repository: mockLoginRepository);
  });

  final tNumber = '0958676066';
  final tName = 'Taha Malas';
  final tPassword = '12345678';
  final tFcmToken = 'laiksdoasodiasdiaosid';
  final tIsRememberMe = false;
  final tToken = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9';

  final tUser = User(token: tToken, name: tName);

  test(
    'should login user using the repository',
    () async {
      // arrange
      when(mockLoginRepository.loginUser(any, any, any, any))
          .thenAnswer((_) async => Right(tUser));
      // act
      final result = await useCase(
        LoginParams(
            email: tNumber,
            password: tPassword,
            fcmToken: tFcmToken,
            isRememberMe: tIsRememberMe),
      );

      // assert
      verify(mockLoginRepository.loginUser(
          tNumber, tPassword, tFcmToken, tIsRememberMe));

      verifyNoMoreInteractions(mockLoginRepository);
      expect(result, Right(tUser));
    },
  );

  test(
    'should return server failure',
    () async {
      // arrange
      when(mockLoginRepository.loginUser(any, any, any, any))
          .thenAnswer((_) async => Left(ServerFailure()));
      // act
      final result = await useCase(
        LoginParams(
            email: tNumber,
            password: tPassword,
            fcmToken: tFcmToken,
            isRememberMe: tIsRememberMe),
      );

      // assert
      verify(mockLoginRepository.loginUser(
          tNumber, tPassword, tFcmToken, tIsRememberMe));

      verifyNoMoreInteractions(mockLoginRepository);
      expect(result, Left(ServerFailure()));
    },
  );
}
