import 'package:english_dictionary/core/feature/words/data/models/gpt_request_model.dart';

abstract interface class IGptService {
  Future<String> generateText(GptRequestModel request);
}
