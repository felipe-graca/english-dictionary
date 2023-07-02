import 'package:dio/dio.dart';
import 'package:english_dictionary/core/services/http/http_service.dart';

abstract interface class IHttpService {
  Future get(String? url, {Options? options});
  Future post(String path, {dynamic data, Options? options});
  Future put(String path, {dynamic data, Options? options});
  Future delete(String url, {dynamic data, Options? options});
  HttpResponseStatus handerResponseStatus(int? statusCode);

  Future<Options> buildAuthOptions();
}

class HttpResponse {
  final dynamic data;
  final int? statusCode;

  HttpResponse({required this.data, required this.statusCode});
}
