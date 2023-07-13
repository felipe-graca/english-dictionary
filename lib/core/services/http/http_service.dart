import 'package:dio/dio.dart';
import 'package:english_dictionary/core/services/http/http_service_interface.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

enum HttpResponseStatus {
  success,
  unAuthorized,
  notFound,
  serverError,
  unknownError,
}

base class HttpService implements IHttpService {
  final Dio _dio;
  HttpService(this._dio) {
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ));
  }

  @override
  HttpResponseStatus handerResponseStatus(int? statusCode) {
    switch (statusCode) {
      case int code when code >= 200 && code < 300:
        return HttpResponseStatus.success;
      case 401:
        return HttpResponseStatus.unAuthorized;
      case 404:
        return HttpResponseStatus.notFound;
      case 500:
        return HttpResponseStatus.serverError;
      default:
        return HttpResponseStatus.unknownError;
    }
  }

  @override
  Future<Options> buildAuthOptions({Options? options}) async {
    final options0 = options ?? Options();

    options0.headers ??= {};
    options0.headers!.addAll({});

    return options0;
  }

  @override
  Future get(String? url, {Options? options}) async {
    final response = await _dio.get(url!, options: options ?? await buildAuthOptions());
    return response;
  }

  @override
  Future post(String path, {dynamic data, Options? options}) async {
    final response = await _dio.post(path, data: data, options: options ?? await buildAuthOptions());
    return response;
  }

  @override
  Future put(String path, {dynamic data, Options? options}) async {
    final response = await _dio.put(path, data: data, options: options ?? await buildAuthOptions());
    return response;
  }

  @override
  Future delete(String path, {dynamic data, Options? options}) async {
    final response = await _dio.delete(path, data: data, options: options ?? await buildAuthOptions());
    return response;
  }

  @override
  Future download(String urlPath, {Options? options}) async {
    final response = await _dio.get(urlPath, options: options ?? Options(responseType: ResponseType.bytes));
    return response;
  }
}
