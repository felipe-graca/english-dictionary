import 'package:english_dictionary/core/feature/words/core/errors/words_failure.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/words_request_entity.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';

abstract interface class IGetGptWordsUsecase implements UseCase<List<WordEntity>, WordsRequestEntity> {
  @override
  Future<(GetWordsFailure?, List<WordEntity>)> call(WordsRequestEntity entity);
}
