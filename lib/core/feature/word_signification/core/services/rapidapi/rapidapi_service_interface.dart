import 'package:dio/dio.dart';

abstract interface class IRapidapiService {
  Future<Options> buildAuthOptions({Options? options});
  Future get(String? url, {Options? options});
}
