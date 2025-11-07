import 'package:dio/dio.dart';
import 'package:loomi_project/config/interceptors/dio_interceptor.dart';

class DioClient {
  final Dio dio;

  DioClient({
    required String baseUrl,
    Duration connectTimeout = const Duration(seconds: 10),
    Duration receiveTimeout = const Duration(seconds: 10),
    Map<String, dynamic>? headers,
    bool enableLogging = false,
  }) : dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: connectTimeout,
            receiveTimeout: receiveTimeout,
            headers: headers ?? {'Content-Type': 'application/json'},
          ),
        ) {
    dio.interceptors.add(
      AppInterceptors(dio),
    );

    if (enableLogging) {
      dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (obj) => print('[DIO] $obj'),
      ));
    }
  }
}
