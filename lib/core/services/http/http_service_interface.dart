import 'package:dio/dio.dart';

abstract interface class IHttpService {
  Future get(String? url, {Options? options});
  Future post(String path, {dynamic data, Options? options});
  Future put(String path, {dynamic data, Options? options});
  Future delete(String url, {dynamic data, Options? options});
  Future download(String urlPath, {Options? options});

  Future<Options> buildAuthOptions();
}

class HttpResponse {
  final dynamic data;
  final int? statusCode;

  HttpResponse({required this.data, required this.statusCode});
}
