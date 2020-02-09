import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_germany/core/data/base_remote_datasource.dart';
import 'package:flutter_test_germany/core/util/constants.dart';
import 'package:flutter_test_germany/feature/login/data/models/user_model.dart';

abstract class LoginRemoteDataSource extends BaseRemoteDataSource {
  Future<UserModel> loginUser(String email, String password, String fcmToken);
}

class LoginRemoteDataSourceImpl extends BaseRemoteDataSourceImpl
    implements LoginRemoteDataSource {
  final Dio dio;

  LoginRemoteDataSourceImpl({@required this.dio}) : super(dio: dio);

  @override
  Future<UserModel> loginUser(
      String email, String password, String fcmToken) async {
    return await performPostRequest<UserModel>(
      Endpoints.LOGIN,
      RequestBody.login(email: email, password: password, fcmToken: fcmToken),
      FullTypes.LOGIN,
      options: OPTION,
    );
  }
}
