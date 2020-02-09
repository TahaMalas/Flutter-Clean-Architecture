import 'package:flutter/material.dart';
import 'package:flutter_test_germany/core/util/constants.dart';
import 'package:flutter_test_germany/feature/login/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LoginLocalDataSource {
  Future<void> updateUser(UserModel user, bool isRememberMe);
}

class LoginLocalDataSourceImpl implements LoginLocalDataSource {
  final SharedPreferences sharedPreferences;

  LoginLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<void> updateUser(UserModel user, bool isRememberMe) {
    print(user.token);
    sharedPreferences.setString(
        SharedPreferencesKeys.API_TOKEN, 'Bearer ${user.token}');
    sharedPreferences.setString(SharedPreferencesKeys.NAME, user.name);
    sharedPreferences.setInt(SharedPreferencesKeys.ID, user.id);
    sharedPreferences.setBool(
        SharedPreferencesKeys.IS_REMEMBER_ME, isRememberMe);
    return Future.value();
  }
}
