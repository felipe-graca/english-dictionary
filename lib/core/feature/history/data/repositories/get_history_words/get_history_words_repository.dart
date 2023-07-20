import 'package:english_dictionary/core/feature/history/core/errors/hisotry_failure.dart';
import 'package:english_dictionary/core/feature/history/data/datasources/get_history_words/get_history_words_datasource_interface.dart';
import 'package:english_dictionary/core/feature/history/domain/entities/history_word_entity.dart';
import 'package:english_dictionary/core/feature/history/domain/repositories/get_history_words/get_history_words_repository_interface.dart';

class GetHistoryWordsRepository implements IGetHistoryWordsRepository {
  final IGetHistoryWordsDatasource _datasource;

  GetHistoryWordsRepository(this._datasource);

  @override
  Future<(GetHistoryWordsFailure?, List<HistoryWordEntity>)> getHistoryWords() async {
    try {
      return (null, await _datasource.getHistoryWords());
    } on GetHistoryWordsFailure catch (e) {
      return (e, <HistoryWordEntity>[]);
    }
  }
}
