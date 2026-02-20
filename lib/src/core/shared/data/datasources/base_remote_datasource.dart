import 'package:dio/dio.dart';

class BaseRemoteDatasource {
  late final Dio client;
  int get timeout => 60;

  BaseRemoteDatasource({
    required Dio? dioClient,
    required String baseUrl,
    bool enableInterceptors = true,
  }) {
    client =
        dioClient ??
        Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: Duration(seconds: timeout),
            receiveTimeout: Duration(seconds: timeout),
            sendTimeout: Duration(seconds: timeout),
          ),
        );
  }
}
