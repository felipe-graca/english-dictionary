import 'package:english_dictionary/core/feature/words/core/errors/words_failure.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/words_request_entity.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
import 'package:english_dictionary/core/feature/words/domain/repositories/get_gpt_words/get_gpt_words_repository_interface.dart';
import 'package:english_dictionary/core/feature/words/domain/usecases/get_gpt_words/get_gpt_words_usecase_interface.dart';

class GetGptWordsUsecase implements IGetGptWordsUsecase {
  final IGetGptWordsRepository _repository;

  GetGptWordsUsecase(this._repository);

  @override
  Future<(GetWordsFailure?, List<WordEntity>)> call(WordsRequestEntity entity) async => await _repository.getGptWords(entity);
}
