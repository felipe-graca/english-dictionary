import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/favorites/core/errors/favorites_failure.dart';
import 'package:english_dictionary/core/feature/favorites/domain/entities/favorite_word_entity.dart';

abstract interface class ISaveFavoriteWordRepository {
  Future<Either<SaveFavoriteWordFailure, FavoriteWordEntity>> saveFavoriteWord(FavoriteWordEntity model);
}
