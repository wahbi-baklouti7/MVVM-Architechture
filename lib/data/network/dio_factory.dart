import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm_architechture/app/app_prefs.dart';
import 'package:mvvm_architechture/app/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String applicationJson = "application/json";
const String contentType = "Content-Type"; // Todo: this change to upper case
const String accept = "Accept";// Todo: this change to upper case
const String authorization = "authorization";
const String defaultLanguage = "language";

class DioFactory {

  final AppPreferences _appPreferences;
  DioFactory(this._appPreferences);

  Future<Dio> getDio() async {
    Dio dio = Dio();

    String language=  await _appPreferences.getAppLanguage();
    Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,
      authorization: Constants.token,
      defaultLanguage: language,
    };
    dio.options = BaseOptions(
        baseUrl: Constants.baseUrl,
        headers: headers,
        receiveTimeout: Constants.apiTimeOut,
        sendTimeout: Constants.apiTimeOut);

    if (!kReleaseMode) {
      // its debug mode so print logs
      dio.interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true, responseHeader: true));
    }
    return dio;
  }
}
