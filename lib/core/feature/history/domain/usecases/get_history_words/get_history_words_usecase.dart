import 'package:english_dictionary/core/feature/history/core/errors/hisotry_failure.dart';
import 'package:english_dictionary/core/feature/history/domain/entities/history_word_entity.dart';
import 'package:english_dictionary/core/feature/history/domain/repositories/get_history_words/get_history_words_repository_interface.dart';
import 'package:english_dictionary/core/feature/history/domain/usecases/get_history_words/get_history_words_usecase_interface.dart';

class GetHistoryWordsUsecase implements IGetHistoryWordsUsecase {
  final IGetHistoryWordsRepository _repository;

  GetHistoryWordsUsecase(this._repository);

  @override
  Future<(GetHistoryWordsFailure?, List<HistoryWordEntity>)> call(noParams) async => await _repository.getHistoryWords();
}
