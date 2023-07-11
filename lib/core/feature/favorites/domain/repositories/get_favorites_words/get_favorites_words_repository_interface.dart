import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/favorites/core/errors/favorites_failure.dart';
import 'package:english_dictionary/core/feature/favorites/domain/entities/favorite_word_entity.dart';

abstract interface class IGetFavoritesWordsRepository {
  Future<Either<GetFavoritesWordsFailure, List<FavoriteWordEntity>>> getFavoritesWords();
}
