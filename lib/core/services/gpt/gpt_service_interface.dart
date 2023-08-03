import 'package:english_dictionary/core/feature/word_signification/data/model/signification_request_model.dart';
import 'package:english_dictionary/core/feature/words/data/models/words_request_model.dart';

abstract interface class IGptService {
  Future<String> generateWordsText(WordsRequestModel request);
  Future<String> generateSignificationText(SignificationRequestModel request);
}
