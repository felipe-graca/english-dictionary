import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/history/core/errors/hisotry_failure.dart';
import 'package:english_dictionary/core/feature/history/domain/repositories/clear_history_words/clear_history_word_repository_interface.dart';
import 'package:english_dictionary/core/feature/history/domain/usecases/clear_history_word/clear_history_word_usecase_interface.dart';

class ClearHistoryWordsUsecase implements IClearHistoryWordsUsecase {
  final IClearHistoryWordRepository repository;

  ClearHistoryWordsUsecase(this.repository);

  @override
  Future<Either<ClearHistoryWordsFailure, bool>> call(noParams) async {
    return await repository.clearHistoryWords();
  }
}
