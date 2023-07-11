import 'package:english_dictionary/core/feature/favorites/data/models/favorites_word_model.dart';

abstract class IRemoveFavoriteWordDatasource {
  Future<bool> removeFavoriteWord(FavoriteWordModel model);
}
