import 'dart:developer';

import 'package:dio/dio.dart';

class MyDio {
  Dio dio = Dio();

  get () => dio;

  MyDio() {
    dio.options.baseUrl = "http://localhost:8080";
    dio.options.connectTimeout = Duration(seconds: 15);
    dio.options.receiveTimeout = Duration(seconds: 15);
    dio.options.headers = {
      "Content-Type": "application/json",
    };
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        log('REQUEST[${options.method}] => PATH: ${options.path}');
        return handler.next(options); // 요청 계속 진행
      },
      onResponse: (response, handler) {
        log('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
        log(response.data.toString());
        return handler.next(response); // 응답 계속 진행
      },
      onError: (DioException e, handler) {
        log('ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}');
        return handler.next(e); // 에러 계속 진행
      },
    ));
  }
}