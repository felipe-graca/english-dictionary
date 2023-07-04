import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/favorites/data/datasources/get_favorites_words/get_favorites_words_datasource_interface.dart';
import 'package:english_dictionary/core/feature/favorites/domain/repositories/get_favorites_words/get_favorites_words_repository_interface.dart';
import 'package:english_dictionary/core/feature/words/core/errors/words_failure.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';

class GetFavoritesWordsRepository implements IGetFavoritesWordsRepository {
  final IGetFavoritesWordsDatasource _datasource;

  GetFavoritesWordsRepository(this._datasource);

  @override
  Future<Either<GetFavoritesWordsFailure, List<WordEntity>>> getFavoritesWords() async {
    try {
      return Right(await _datasource.getFavoritesWords());
    } on GetFavoritesWordsFailure catch (e) {
      return Left(e);
    }
  }
}
