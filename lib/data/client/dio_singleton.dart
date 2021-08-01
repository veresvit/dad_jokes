import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioSingleton {
  static late Dio _dio;
  static bool _instanceInitialized = false;

  static Dio instance() {
    if (!_instanceInitialized) {
      _dio = Dio();
      if (kDebugMode) {
        _dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
      }
      _dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            options.headers['Accept'] = 'application/json';
            handler.next(options);
          },
        ),
      );
      _instanceInitialized = true;
    }
    return _dio;
  }
}
