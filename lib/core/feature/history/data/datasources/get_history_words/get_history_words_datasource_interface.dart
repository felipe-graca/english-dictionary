import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';

abstract interface class IGetHistoryWordsDatasource {
  Future<List<WordEntity>> getHistoryWords();
}
