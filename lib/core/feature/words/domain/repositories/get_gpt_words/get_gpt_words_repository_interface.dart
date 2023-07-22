import 'package:english_dictionary/core/feature/words/core/errors/words_failure.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/gpt_request_entity.dart';

abstract interface class IGetGptWordsRepository {
  Future<(GetWordsFailure?, List<String>)> getGptWords(GptRequestEntity word);
}
