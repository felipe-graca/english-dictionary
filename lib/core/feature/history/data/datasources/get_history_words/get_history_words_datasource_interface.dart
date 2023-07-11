import 'package:english_dictionary/core/feature/history/data/models/history_word_model.dart';

abstract interface class IGetHistoryWordsDatasource {
  Future<List<HistoryWordModel>> getHistoryWords();
}
