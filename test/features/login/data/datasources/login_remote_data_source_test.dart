import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_germany/core/error/exceptions.dart';
import 'package:flutter_test_germany/core/util/constants.dart';
import 'package:flutter_test_germany/feature/login/data/datasources/login_remote_data_source.dart';
import 'package:flutter_test_germany/feature/login/data/models/user_model.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockDio extends Mock implements Dio {}

void main() {
  MockDio mockDio;
  LoginRemoteDataSourceImpl dataSource;

  setUp(() {
    mockDio = MockDio();
    mockDio.options = BASE_OPTIONS;
    dataSource = LoginRemoteDataSourceImpl(dio: mockDio);
  });

  final tNumber = '0958676066';
  final tPassword = '12345678';
  final tFcmToken = 'aiiodjsadjasdoajsodajsdoaodjoajsd';

  void setUpMockDioSuccess200TrueStatusLogin() {
    when(
      mockDio.post(
        any,
        options: OPTION,
        data: RequestBody.login(
          email: tNumber,
          password: tPassword,
          fcmToken: tFcmToken,
        ),
      ),
    ).thenAnswer(
      (_) async => Response(data: fixture('login/login.json'), statusCode: 200),
    );
  }

  void setUpMockDioError404Login() {
    when(
      mockDio.post(
        any,
        options: OPTION,
        data: RequestBody.login(
            email: tNumber, password: tPassword, fcmToken: tFcmToken),
      ),
    ).thenAnswer(
      (_) async => Response(
        data: 'Something went wrong',
        statusCode: 404,
      ),
    );
  }

  void setUpMockDioSuccess200FalseStatusLogin() {
    when(
      mockDio.post(
        any,
        options: OPTION,
        data: RequestBody.login(
            email: tNumber, password: tPassword, fcmToken: tFcmToken),
      ),
    ).thenAnswer(
      (_) async =>
          Response(data: fixture('login/login_error.json'), statusCode: 200),
    );
  }

  group('login user', () {
    final tName = 'Taha';
    final tToken =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjdiN2E0MjMyYmYyMTc3NmQwOTE5MGU2OWVjNmQ0YTY3NWNlMjBkMmI2OWJkMmI0NjAzZjcxZDk5ODM0NDg0ZDBkYWIyMDQxZjkyMWExZGEwIn0.eyJhdWQiOiIxIiwianRpIjoiN2I3YTQyMzJiZjIxNzc2ZDA5MTkwZTY5ZWM2ZDRhNjc1Y2UyMGQyYjY5YmQyYjQ2MDNmNzFkOTk4MzQ0ODRkMGRhYjIwNDFmOTIxYTFkYTAiLCJpYXQiOjE1NzYwMDYxNzksIm5iZiI6MTU3NjAwNjE3OSwiZXhwIjoxNjA3NjI4NTc5LCJzdWIiOiI1Iiwic2NvcGVzIjpbXX0.OEOmcbJ7hFzfPNnQzfqt7Luil4gOfrud32kuN28tYR9PRZLj9mpqMJZHmLOW6qRlLQEX2zLsProifqXFFWWeBEgprUGW0oAGb_lzw6SPz8AaWbPHNNUR_4zkio6HiTkKAFCMfZUbnExl0WwoVihKVTXzuikBiuAqdpyhUT63Khhrbq0t4vDOqke9qTpX2v3wBNBubh0Eu3x-r95gk678dlcI7Bo975iHpYU5hNPYBALeE7OEh1ptaue2NGgHWw35rZeky0zJUHBperEYftuihXCzoG902Z_Ur_Z_tt-lbbmnC59xd4vj3tITfgAN3ZlVBpCf0FVUtDabkQtKfC_XmtecU0OAWovzNrvmo2YDpaizcolOJhendFr4rpx51FOnSJE-nlfU96XUXBhNOgh_fsIKWpbyhA3fM_dBUZW1l0CuKHr4mFGTb66lArfy1Fcpu63_bXohC7Qzbf1U45SYeuhWL580nxXSvGvzufLkmtlRwvhwN8-JbVdDcovpRHD_PL3Txn3L2nHs-Afta7WULSuX0biSulFjYRMR6D9nMFCE4CU4EBYUhYh-w0kH-80Y8jbLJq5usDHfMGKx-66eB33sDTM6zMIR8PmT5vz4JY1NT5XKll7II8PGcdFwjGGdoe64uK6mSnIU5vDpLEKoNve-BTXuxZ9awmk9csxnjiY';

    final tID = 5;

    final UserModel tUserModel = UserModel(
      tID,
      tToken,
      tName,
    );

    test(
      '''should perform a POST request on a URL with user/login
       being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockDioSuccess200TrueStatusLogin();

        // act
        dataSource.loginUser(tNumber, tPassword, tFcmToken);

        // assert
        verify(
          mockDio.post(
            Endpoints.LOGIN,
            options: OPTION,
            data: RequestBody.login(
                email: tNumber, password: tPassword, fcmToken: tFcmToken),
          ),
        );
      },
    );

    test(
      'should return User when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockDioSuccess200TrueStatusLogin();
        // act
        final result =
            await dataSource.loginUser(tNumber, tPassword, tFcmToken);
        // assert
        expect(result, equals(tUserModel));
      },
    );

    test(
      'should throw a ServerException when the status is false',
      () async {
        // arrange
        setUpMockDioSuccess200FalseStatusLogin();
        // act
        final result = dataSource.loginUser;
        // assert
        expect(() => result(tNumber, tPassword, tFcmToken),
            throwsA(predicate((e) => e is ServerException)));
      },
    );

    test(
      'should throw a ServerException when the response code is not 200',
      () async {
        // arrange
        setUpMockDioError404Login();
        // act
        final result = dataSource.loginUser;
        // assert
        expect(() => result(tNumber, tPassword, tFcmToken),
            throwsA(predicate((e) => e is ServerException)));
      },
    );
  });
}
