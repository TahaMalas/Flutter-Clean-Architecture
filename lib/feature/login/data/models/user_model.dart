library user_model;

import 'package:flutter_test_germany/feature/login/domain/entities/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {

  static final String className = 'UserModel';

  @JsonKey(name: 'access_token')
  final String token;
  @JsonKey()
  final String name;
  @JsonKey()
  final int id;

  UserModel(this.id, this.token, this.name);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

}

