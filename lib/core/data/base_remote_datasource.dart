import 'dart:convert';

import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_germany/core/error/exceptions.dart';
import 'package:flutter_test_germany/core/network/models/base_response_model.dart';
import 'package:flutter_test_germany/core/util/constants.dart';

abstract class BaseRemoteDataSource {
  @protected
  Future<T> performPostRequest<T>(
    String endpoint,
    FormData data,
    FullType type, {
    Options options,
  });

  @protected
  Future<T> performGetRequest<T>(
    String endpoint,
    FullType type,
    String token,
    String language,
  );
}

class BaseRemoteDataSourceImpl extends BaseRemoteDataSource {
  final Dio dio;

  BaseRemoteDataSourceImpl({@required this.dio});

  @override
  Future<T> performGetRequest<T>(
      String endpoint, FullType type, String token, String language) async {
    print('performGetRequest');
    try {
      final response = await dio.get(
        endpoint,
        options: GetOptions.getOptionsWithToken(token, language: language),
      );
      if (response.statusCode == 200) {
        final BaseResponseModel<T> finalResponse =
            BaseResponseModel<T>.fromJson(json.decode(response.data));
//            .deserialize(json.decode(response.data), specifiedType: type);
        if (finalResponse.status) {
          print(' Final Response status is ${finalResponse.status}');
          return finalResponse.data;
        } else {
          print('e is error');
          throw ServerException();
        }
      } else {
        print('e is error');
        throw ServerException();
      }
    } catch (e) {
      print('e is $e');
      throw ServerException();
    }
  }

  @override
  Future<T> performPostRequest<T>(
    String endpoint,
    FormData data,
    FullType type, {
    @required Options options,
  }) async {
    try {
      final response = await dio.post(
        endpoint,
        data: data,
        options: options,
      );
      if (response.statusCode == 200) {
        final BaseResponseModel<T> finalResponse =
            BaseResponseModel<T>.fromJson(json.decode(response.data));
//            .deserialize(json.decode(response.data), specifiedType: type);
        if (finalResponse.status) {
          return finalResponse.data;
        } else {
          print('e is error');
          throw ServerException();
        }
      } else {
        print('e is error');
        throw ServerException();
      }
    } catch (e) {
      print('e is $e');
      throw ServerException();
    }
  }
}
