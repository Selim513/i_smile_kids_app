import 'dart:io';

import 'package:dio/dio.dart';

class DioHelper {
  final Dio dio;

  DioHelper(this.dio);
}

class DioFactory {
  static Future<Dio> createDio() async {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://ismilekids-api.runasp.net/api',

        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          "x-tenant": "sst",

          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptLanguageHeader: 'en',

          // "responsetype": "ResponseType.json",
          // "contenttype": "application/json",
        },
      ),
    );

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    return dio;
  }
}
