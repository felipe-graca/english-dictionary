import 'package:dio/dio.dart';
import 'package:english_dictionary/core/feature/words/core/errors/words_failure.dart';
import 'package:english_dictionary/core/feature/words/core/services/gpt_service/gpt_service_interface.dart';
import 'package:english_dictionary/core/feature/words/data/models/gpt_request_model.dart';
import 'package:english_dictionary/core/services/http/http_service.dart';

final class GptService extends HttpService implements IGptService {
  GptService(Dio dio) : super(dio);

  @override
  Future<String> generateText(GptRequestModel request) async {
    try {
      const url = String.fromEnvironment('GPT_API_URL');
      final response = await super.post(url, data: request.toJson(), options: await _buildAuthOptions());
      return response.data['choices'][0]['text'];
    } on DioException {
      throw GptFailure();
    }
  }

  Future<Options> _buildAuthOptions() async {
    const apiKey = String.fromEnvironment("GPT_API_KEY");

    final options = Options();

    options.headers ??= {};
    options.headers!.addAll({
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    });

    return options;
  }
}
