// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

import 'package:english_dictionary/core/errors/gpt_failure.dart';
import 'package:english_dictionary/core/feature/word_signification/data/model/signification_request_model.dart';
import 'package:english_dictionary/core/feature/words/data/models/words_request_model.dart';
import 'package:english_dictionary/core/services/gpt/gpt_service_interface.dart';
import 'package:english_dictionary/core/services/http/http_service.dart';

final class GptService extends HttpService implements IGptService {
  GptService(Dio dio) : super(dio);

  @override
  Future<String> generateSignificationText(SignificationRequestModel request) async => _fetch(dataJson: request.toJson());

  @override
  Future<String> generateWordsText(WordsRequestModel request) async => _fetch(dataJson: request.toJson());

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

  Future<String> _fetch({required String dataJson}) async {
    try {
      const url = "https://api.openai.com/v1/chat/completions";
      final response = await super.post(url, data: dataJson, options: await _buildAuthOptions());
      return response.data['choices'][0]['message']['content'];
    } on DioException {
      throw GptFailure();
    }
  }
}

class Gpt {
  final String model = 'gpt-3.5-turbo';
}
