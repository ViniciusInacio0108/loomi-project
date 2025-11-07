import 'package:dio/dio.dart';

class AppInterceptors extends Interceptor {
  final Dio dio;
  AppInterceptors(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Ex: add token or other configs
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Here we would deal with errors in the api call
    super.onError(err, handler);
  }
}
