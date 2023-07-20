import 'package:english_dictionary/core/feature/favorites/core/errors/favorites_failure.dart';
import 'package:english_dictionary/core/feature/favorites/data/datasources/save_favorite_word/save_favorite_word_datasource_interface.dart';
import 'package:english_dictionary/core/feature/favorites/domain/entities/favorite_word_entity.dart';
import 'package:english_dictionary/core/feature/favorites/domain/repositories/save_favorite_word/save_favorite_word_interface.dart';

class SaveFavoriteWordRepository implements ISaveFavoriteWordRepository {
  final ISaveFavoriteWordDatasource _datasource;

  SaveFavoriteWordRepository(this._datasource);
  @override
  Future<(SaveFavoriteWordFailure?, bool)> saveFavoriteWord(FavoriteWordEntity entity) async {
    try {
      return (null, await _datasource.saveFavoriteWord(entity.toModel()));
    } on SaveFavoriteWordFailure catch (e) {
      return (e, false);
    }
  }
}
