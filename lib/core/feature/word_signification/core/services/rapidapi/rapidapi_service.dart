import 'package:dio/dio.dart';
import 'package:english_dictionary/core/feature/word_signification/core/services/rapidapi/rapidapi_service_interface.dart';
import 'package:english_dictionary/core/services/http/http_service.dart';

final class RapidapiService extends HttpService implements IRapidapiService {
  RapidapiService(Dio dio) : super(dio);

  @override
  Future<Options> buildAuthOptions({Options? options}) async {
    const token = String.fromEnvironment("WORD_SIGNIFICATION_API_KEY");

    final options0 = options ?? Options();

    options0.headers ??= {};
    options0.headers!.addAll({
      'X-RapidAPI-Key': token,
      'X-RapidAPI-Host': 'wordsapiv1.p.rapidapi.com',
    });

    return options0;
  }

  @override
  Future get(String? url, {Options? options}) async {
    final response = await super.get(url, options: options ?? await buildAuthOptions());
    return response;
  }
}
