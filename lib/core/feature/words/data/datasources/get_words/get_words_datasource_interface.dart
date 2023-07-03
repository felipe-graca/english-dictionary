import 'package:english_dictionary/core/feature/words/data/models/word_model.dart';

abstract interface class IGetWordsDatasource {
  Future<List<WordModel>> getWords();
}
