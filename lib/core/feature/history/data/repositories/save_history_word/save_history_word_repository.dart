import 'package:english_dictionary/core/feature/history/core/errors/hisotry_failure.dart';
import 'package:english_dictionary/core/feature/history/data/datasources/save_history_word/save_history_word_datasource_interface.dart';
import 'package:english_dictionary/core/feature/history/domain/entities/history_word_entity.dart';
import 'package:english_dictionary/core/feature/history/domain/repositories/save_history_word/save_history_word_interface.dart';

class SaveHistoryWordRepository implements ISaveHistoryWordRepository {
  final ISaveHistoryWordDatasource _datasource;

  SaveHistoryWordRepository(this._datasource);
  @override
  Future<(SaveHistoryWordFailure?, bool)> saveHistoryWord(HistoryWordEntity entity) async {
    try {
      return (null, await _datasource.saveHistoryWord(entity.toModel()));
    } on SaveHistoryWordFailure catch (e) {
      return (e, false);
    }
  }
}
