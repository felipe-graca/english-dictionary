import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/history/core/errors/hisotry_failure.dart';
import 'package:english_dictionary/core/feature/history/data/datasources/clear_history_words/clear_history_words_datasource_interface.dart';
import 'package:english_dictionary/core/feature/history/domain/repositories/clear_history_words/clear_history_word_repository_interface.dart';

class ClearHistoryWordRepository implements IClearHistoryWordRepository {
  final IClearHistoryWordsDatasource _datasource;

  ClearHistoryWordRepository(this._datasource);

  @override
  Future<Either<ClearHistoryWordsFailure, bool>> clearHistoryWords() async {
    try {
      return Right(await _datasource.clearHistoryWords());
    } on ClearHistoryWordsFailure catch (e) {
      return Left(e);
    }
  }
}
