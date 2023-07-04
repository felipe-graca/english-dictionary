import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/favorites/data/datasources/save_favorite_word/save_favorite_word_datasource_interface.dart';
import 'package:english_dictionary/core/feature/favorites/domain/repositories/save_favorite_word/save_favorite_word_interface.dart';
import 'package:english_dictionary/core/feature/words/core/errors/words_failure.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';

class SaveFavoriteWordRepository implements ISaveFavoriteWordRepository {
  final ISaveHistoryWordDatasource _datasource;

  SaveFavoriteWordRepository(this._datasource);
  @override
  Future<Either<SaveFavoriteWordFailure, WordEntity>> saveFavoriteWord(WordEntity model) async {
    try {
      final result = await _datasource.saveFavoriteWord(model.toModel());
      return Right(result.toEntity());
    } on SaveFavoriteWordFailure catch (e) {
      return Left(e);
    }
  }
}
