import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_germany/core/util/constants.dart';
import 'package:flutter_test_germany/feature/login/data/datasources/login_local_data_source.dart';
import 'package:flutter_test_germany/feature/login/data/models/user_model.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  LoginLocalDataSourceImpl _loginLocalDataSourceImpl;

  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    _loginLocalDataSourceImpl = LoginLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });
  final tToken = 'asdasdasdasd';
  final tName = 'Taha Malas';
  final tID = 38;
  final tIsConfirmed = false;
  final tIsRememberMe = true;

  test(
    'should update the user in shared preferenses',
    () async {
      // act
      await _loginLocalDataSourceImpl.updateUser(
        UserModel(tID, tToken, tName),
        tIsRememberMe,
      );

      // assert
      verify(mockSharedPreferences.setString(
          SharedPreferencesKeys.API_TOKEN, 'Bearer $tToken'));

      verify(
          mockSharedPreferences.setString(SharedPreferencesKeys.NAME, tName));

      verify(mockSharedPreferences.setBool(
          SharedPreferencesKeys.IS_REMEMBER_ME, tIsRememberMe));

      verify(mockSharedPreferences.setInt(SharedPreferencesKeys.ID, tID));

      verifyNoMoreInteractions(mockSharedPreferences);
    },
  );
}
