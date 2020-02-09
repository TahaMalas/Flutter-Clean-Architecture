library base_response_model;

import 'package:flutter_test_germany/feature/login/data/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_response_model.g.dart';

@JsonSerializable()
class BaseResponseModel<T> {
  @JsonKey(name: 'status')
  final bool status;
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'data', fromJson: _dataFromJson, toJson: _dataToJson)
  final T data;

  BaseResponseModel({this.status, this.message, this.data});

  factory BaseResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseModelFromJson<T>(json);
}

T _dataFromJson<T>(Map<String, dynamic> input) {
  if (T.toString() == UserModel.className) {
    return UserModel.fromJson(input) as T;
  }
  throw Exception('test');
}

Map<String, dynamic> _dataToJson<T, S, U>(T input, [S other1, U other2]) =>
    {'data': input};
