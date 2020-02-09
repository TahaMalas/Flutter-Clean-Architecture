import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_germany/core/network/models/base_response_model.dart';
import 'package:flutter_test_germany/feature/login/data/models/user_model.dart';

class SharedPreferencesKeys {
  static const API_TOKEN = 'api_token';
  static const IS_CONFIRMED = 'is_confirmed';
  static const NAME = 'name';
  static const IS_REMEMBER_ME = 'is_remember_me';
  static const ID = 'id';
  static const IS_LOGGED_IN = 'is_logged_in';
}

class Endpoints {
  static const BASE_URL = 'https://dashboard.cartsorder.com/api/';
  static const IMAGE_URL = 'https://dashboard.cartsorder.com/';

  static const LOGIN = 'login';
}

class RequestBody {
  static FormData login(
      {@required String email, @required String password, String fcmToken}) {
    return FormData.from({
      'email': email,
      'password': password,
      'fcm_token': fcmToken,
    });
  }
}

const SERVER_FAILURE_MESSAGE = 0;
const CACHE_FAILURE_MESSAGE = 1;

class LoginTexts {
  static const int NO_ERROR = 0;
  static const int INVALID_EMAIL = 1;
  static const int INVALID_PASSWORD = 2;
  static const int REMEMBER_ME = 3;
  static const int FORGOT_PASSWORD = 4;
  static const int LOGIN = 5;
  static const int OR = 6;
  static const int REGISTER = 7;
  static const int CONTINUE_AS_GUEST = 8;
}

Map<int, String> loginTexts = {
  LoginTexts.INVALID_EMAIL: 'invalid_email',
  LoginTexts.INVALID_PASSWORD: 'invalid_password',
  LoginTexts.REMEMBER_ME: 'remember_me',
  LoginTexts.FORGOT_PASSWORD: 'forgot_password',
  LoginTexts.LOGIN: 'login',
  LoginTexts.OR: 'or',
  LoginTexts.REGISTER: 'register',
  LoginTexts.CONTINUE_AS_GUEST: 'continue_as_guest',
};

class FullTypes {
  static const LOGIN = FullType(
    BaseResponseModel,
    const [
      FullType(UserModel),
    ],
  );
}

//class FullTypesFunctions {
//  static login() => BaseResponseModelBuilder<UserModel>();
//}

final BASE_OPTIONS = BaseOptions(
  headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  },
);

final OPTION = Options(
  headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Accept-Language': 'en',
  },
);

class GetOptions {
  static Options options = Options();

  static Options getOptionsWithToken(String token, {String language = ''}) {
    if (token != null && token.isNotEmpty) {
      options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token,
        'Accept-Language': language,
      };
    } else {
      options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Accept-Language': language,
      };
    }
    return options;
  }
}
