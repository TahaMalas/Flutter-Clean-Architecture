// GENERATED CODE - DO NOT MODIFY BY HAND

part of user_model;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    json['id'] as int,
    json['access_token'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'access_token': instance.token,
      'name': instance.name,
      'id': instance.id,
    };
