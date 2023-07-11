import 'package:english_dictionary/core/feature/favorites/data/models/favorites_word_model.dart';

abstract interface class ISaveFavoriteWordDatasource {
  Future<FavoriteWordModel> saveFavoriteWord(FavoriteWordModel model);
}
