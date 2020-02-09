//library serializers;
//
//import 'package:built_collection/built_collection.dart';
//import 'package:built_value/serializer.dart';
//import 'package:built_value/standard_json_plugin.dart';
//import 'package:flutter_test_germany/core/network/models/base_response_model.dart';
//import 'package:flutter_test_germany/core/util/constants.dart';
//import 'package:flutter_test_germany/feature/login/data/models/user_model.dart';
//
//part 'serializers.g.dart';
//
//@SerializersFor(const [
//  UserModel,
//  BaseResponseModel,
//])
//final Serializers serializers = (_$serializers.toBuilder()
//      ..addBuilderFactory(FullTypes.LOGIN, FullTypesFunctions.login)
//      ..addPlugin(StandardJsonPlugin()))
//    .build();
