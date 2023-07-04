import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/history/core/errors/hisotry_failure.dart';
import 'package:english_dictionary/core/feature/history/data/datasources/get_history_words/get_history_words_datasource_interface.dart';
import 'package:english_dictionary/core/feature/history/domain/repositories/get_history_words/get_history_words_repository_interface.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';

class GetHistoryWordsRepository implements IGetHistoryWordsRepository {
  final IGetHistoryWordsDatasource _datasource;

  GetHistoryWordsRepository(this._datasource);

  @override
  Future<Either<GetHistoryWordsFailure, List<WordEntity>>> getHistoryWords() async {
    try {
      return Right(await _datasource.getHistoryWords());
    } on GetHistoryWordsFailure catch (e) {
      return Left(e);
    }
  }
}
