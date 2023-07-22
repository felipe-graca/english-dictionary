import 'package:english_dictionary/core/errors/gpt_failure.dart';
import 'package:english_dictionary/core/feature/words/core/errors/words_failure.dart';
import 'package:english_dictionary/core/services/gpt/gpt_service_interface.dart';
import 'package:english_dictionary/core/feature/words/data/datasources/get_gpt_words/get_gpt_words_datasource_interface.dart';
import 'package:english_dictionary/core/feature/words/data/models/gpt_request_model.dart';

class GetGptWordsDatasource implements IGetGptWordsDatasource {
  final IGptService _gptService;

  GetGptWordsDatasource(this._gptService);
  @override
  Future<String> getGptWords(GptRequestModel word) async {
    try {
      return await _gptService.generateText(word);
    } on GptFailure catch (e) {
      throw GetWordsFailure(message: e.message);
    }
  }
}
