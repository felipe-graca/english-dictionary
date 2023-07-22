import 'package:english_dictionary/core/feature/words/core/errors/words_failure.dart';
import 'package:english_dictionary/core/feature/words/data/datasources/get_words/get_words_datasource_interface.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
import 'package:english_dictionary/core/feature/words/domain/repositories/get_words/get_words_repository_interface.dart';

class GetWordsRepository implements IGetWordsRepository {
  final IGetWordsDatasource _datasource;

  GetWordsRepository(this._datasource);
  @override
  Future<(GetWordsFailure?, List<WordEntity>)> getWords() async {
    try {
      return (null, await _datasource.getWords());
    } on GetWordsFailure catch (e) {
      return (e, <WordEntity>[]);
    }
  }
}
