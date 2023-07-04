import 'package:english_dictionary/core/feature/words/data/models/word_model.dart';

abstract class IRemoveFavoriteWordDatasource {
  Future<bool> removeFavoriteWord(WordModel model);
}
