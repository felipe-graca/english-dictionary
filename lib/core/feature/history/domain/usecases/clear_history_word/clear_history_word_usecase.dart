import 'package:english_dictionary/core/feature/history/core/errors/hisotry_failure.dart';
import 'package:english_dictionary/core/feature/history/domain/repositories/clear_history_words/clear_history_word_repository_interface.dart';
import 'package:english_dictionary/core/feature/history/domain/usecases/clear_history_word/clear_history_word_usecase_interface.dart';

class ClearHistoryWordsUsecase implements IClearHistoryWordsUsecase {
  final IClearHistoryWordRepository _repository;

  ClearHistoryWordsUsecase(this._repository);

  @override
  Future<(ClearHistoryWordsFailure?, bool)> call(noParams) async => await _repository.clearHistoryWords();
}
