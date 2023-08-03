import 'package:english_dictionary/core/feature/words/core/errors/words_failure.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/words_request_entity.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';

abstract interface class IGetGptWordsRepository {
  Future<(GetWordsFailure?, List<WordEntity>)> getGptWords(WordsRequestEntity word);
}
