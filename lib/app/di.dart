import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mvvm_architechture/app/app_prefs.dart';
import 'package:mvvm_architechture/data/data_source/remote_data_source.dart';
import 'package:mvvm_architechture/data/network/app_api.dart';
import 'package:mvvm_architechture/data/network/dio_factory.dart';
import 'package:mvvm_architechture/data/network/errors_handler.dart';
import 'package:mvvm_architechture/data/network/network_info.dart';
import 'package:mvvm_architechture/data/repository/repository_impl.dart';
import 'package:mvvm_architechture/domain/repository/repository.dart';
import 'package:mvvm_architechture/domain/usecase/login_usecase.dart';
import 'package:mvvm_architechture/presentation/login/view_model/login_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

// all generic dependencies
Future<void> initAppModule() async {
  // shared prefs instance
  final sharedPreferences = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // app prefs instance
  instance.registerLazySingleton<AppPreferences>(
      () => AppPreferences(sharedPreferences));

  // network info instance
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  // dio factory instance
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  // app service client instance
  Dio dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));
  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance()));

  // repository

  instance.registerLazySingleton<Repository>(() =>
      RepositoryImpl(instance<RemoteDataSource>(), instance<NetworkInfo>()));
}

void initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    // login usecase
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    // login view model
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}
