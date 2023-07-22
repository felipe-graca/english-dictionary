import 'package:english_dictionary/core/feature/favorites/core/errors/favorites_failure.dart';
import 'package:english_dictionary/core/feature/favorites/data/datasources/get_favorites_words/get_favorites_words_datasource_interface.dart';
import 'package:english_dictionary/core/feature/favorites/domain/entities/favorite_word_entity.dart';
import 'package:english_dictionary/core/feature/favorites/domain/repositories/get_favorites_words/get_favorites_words_repository_interface.dart';

class GetFavoritesWordsRepository implements IGetFavoritesWordsRepository {
  final IGetFavoritesWordsDatasource _datasource;

  GetFavoritesWordsRepository(this._datasource);

  @override
  Future<(GetFavoritesWordsFailure?, List<FavoriteWordEntity>)> getFavoritesWords() async {
    try {
      return (null, await _datasource.getFavoritesWords());
    } on GetFavoritesWordsFailure catch (e) {
      return (e, <FavoriteWordEntity>[]);
    }
  }
}
