import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';

abstract interface class IGetFavoritesWordsDatasource {
  Future<List<WordEntity>> getFavoritesWords();
}
