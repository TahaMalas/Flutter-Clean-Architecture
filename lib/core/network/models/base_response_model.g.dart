// GENERATED CODE - DO NOT MODIFY BY HAND

part of base_response_model;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponseModel<T> _$BaseResponseModelFromJson<T>(Map<String, dynamic> json) {
  return BaseResponseModel<T>(
    status: json['status'] as bool,
    message: json['message'] as String,
    data: _dataFromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BaseResponseModelToJson<T>(
        BaseResponseModel<T> instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': _dataToJson(instance.data),
    };
