import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test_germany/core/data/base_remote_datasource.dart';
import 'package:flutter_test_germany/core/network/network_info.dart';
import 'package:flutter_test_germany/core/util/input_validator.dart';
import 'package:flutter_test_germany/feature/login/data/datasources/login_local_data_source.dart';
import 'package:flutter_test_germany/feature/login/data/datasources/login_remote_data_source.dart';
import 'package:flutter_test_germany/feature/login/domain/repositories/login_repository.dart';
import 'package:flutter_test_germany/feature/login/domain/usecases/login.dart';
import 'package:flutter_test_germany/feature/login/presentation/bloc/login_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/util/constants.dart';
import 'feature/login/data/repositories/login_repository_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(
    () {
      final dio = Dio(
        BaseOptions(
          connectTimeout: 20000,
          baseUrl: Endpoints.BASE_URL,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          responseType: ResponseType.plain,
        ),
      );
      dio.interceptors.add(
        LogInterceptor(
          responseBody: true,
          requestBody: true,
          responseHeader: true,
          requestHeader: true,
          request: true,
        ),
      );
      return dio;
    },
  );
  sl.registerLazySingleton(() => DataConnectionChecker());

  //! Core
  sl.registerLazySingleton(() => InputValidator());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // Data sources
  sl.registerLazySingleton<BaseRemoteDataSource>(
    () => BaseRemoteDataSourceImpl(dio: sl()),
  );

  sl.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(dio: sl()),
  );

  sl.registerLazySingleton<LoginLocalDataSource>(
    () => LoginLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Repository
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
      loginRemoteDataSource: sl(),
      networkInfo: sl(),
      loginLocalDataSource: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => Login(repository: sl()));

  //! Features
  // Bloc
  sl.registerFactory(
    () => LoginBloc(
      login: sl(),
      inputValidator: sl(),
    ),
  );
}
