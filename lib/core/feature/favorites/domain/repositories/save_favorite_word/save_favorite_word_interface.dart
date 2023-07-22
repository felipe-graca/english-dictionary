import 'package:english_dictionary/core/feature/favorites/core/errors/favorites_failure.dart';
import 'package:english_dictionary/core/feature/favorites/domain/entities/favorite_word_entity.dart';

abstract interface class ISaveFavoriteWordRepository {
  Future<(SaveFavoriteWordFailure?, bool)> saveFavoriteWord(FavoriteWordEntity entity);
}
