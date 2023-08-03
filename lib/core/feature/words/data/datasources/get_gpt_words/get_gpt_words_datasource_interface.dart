import 'package:english_dictionary/core/feature/words/data/models/words_request_model.dart';

abstract interface class IGetGptWordsDatasource {
  Future<String> getGptWords(WordsRequestModel word);
}
