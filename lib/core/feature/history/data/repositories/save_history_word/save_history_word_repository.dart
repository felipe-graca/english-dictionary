import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/favorites/data/datasources/save_favorite_word/save_favorite_word_datasource_interface.dart';
import 'package:english_dictionary/core/feature/history/core/errors/hisotry_failure.dart';
import 'package:english_dictionary/core/feature/history/domain/repositories/save_history_word/save_history_word_interface.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';

class SaveHistoryWordRepository implements IHistoryFavoriteWordRepository {
  final ISaveHistoryWordDatasource _datasource;

  SaveHistoryWordRepository(this._datasource);
  @override
  Future<Either<SaveHistoryWordFailure, WordEntity>> saveHistoryWord(WordEntity model) async {
    try {
      final result = await _datasource.saveFavoriteWord(model.toModel());
      return Right(result.toEntity());
    } on SaveHistoryWordFailure catch (e) {
      return Left(e);
    }
  }
}
