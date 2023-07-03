import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/words/core/errors/words_failure.dart';
import 'package:english_dictionary/core/feature/words/data/datasources/remove_favorite_word/remove_favorite_word_datasource_interface.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
import 'package:english_dictionary/core/feature/words/domain/repositories/remove_favorite_word/remove_favorite_word_repository_interface.dart';

class RemoveFavoriteWordRepository implements IRemoveFavoriteWordRepository {
  final IRemoveFavoriteWordDatasource _datasource;

  RemoveFavoriteWordRepository(this._datasource);

  @override
  Future<Either<RemoveFavoriteWordFailure, bool>> removeFavoriteWord(WordEntity model) async {
    try {
      final result = await _datasource.removeFavoriteWord(model.toModel());
      return Right(result);
    } on RemoveFavoriteWordFailure catch (e) {
      return Future.value(Left(e));
    }
  }
}
