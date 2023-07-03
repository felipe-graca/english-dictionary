import 'package:dio/dio.dart';
import 'package:english_dictionary/core/services/http/http_service.dart';

abstract interface class IRapidapiService {
  Future<Options> buildAuthOptions({Options? options});
  Future get(String? url, {Options? options});
  HttpResponseStatus handerResponseStatus(int? statusCode);
}
