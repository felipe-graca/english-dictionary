import 'package:english_dictionary/core/feature/words/core/errors/words_failure.dart';
import 'package:english_dictionary/core/feature/words/data/datasources/get_gpt_words/get_gpt_words_datasource_interface.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/gpt_request_entity.dart';
import 'package:english_dictionary/core/feature/words/domain/repositories/get_gpt_words/get_gpt_words_repository_interface.dart';

class GetGptWordsRepository implements IGetGptWordsRepository {
  final IGetGptWordsDatasource _datasource;

  GetGptWordsRepository(this._datasource);

  @override
  Future<(GetWordsFailure?, List<String>)> getGptWords(GptRequestEntity word) async {
    try {
      final result = await _datasource.getGptWords(word.toModel());

      return (null, _parseResult(result));
    } on GetWordsFailure catch (e) {
      return (e, <String>[]);
    }
  }

  List<String> _parseResult(String result) {
    return result.split('\n');
  }
}
