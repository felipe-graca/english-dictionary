import 'package:english_dictionary/core/feature/words/core/errors/words_failure.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
import 'package:english_dictionary/core/feature/words/domain/repositories/get_words/get_words_repository_interface.dart';
import 'package:english_dictionary/core/feature/words/domain/usecases/get_words/get_words_usecase_interface.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';

class GetWordsUsecase implements IGetWordsUsecase {
  final IGetWordsRepository _repository;

  GetWordsUsecase(this._repository);

  @override
  Future<(GetWordsFailure?, List<WordEntity>)> call(NoParams noParams) async => await _repository.getWords();
}
