import 'package:english_dictionary/core/feature/words/core/errors/words_failure.dart';
import 'package:english_dictionary/core/feature/words/data/datasources/get_gpt_words/get_gpt_words_datasource_interface.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/gpt_request_entity.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
import 'package:english_dictionary/core/feature/words/domain/repositories/get_gpt_words/get_gpt_words_repository_interface.dart';
import 'package:english_dictionary/core/utils/string_extensions.dart';
import 'package:faker/faker.dart';

class GetGptWordsRepository implements IGetGptWordsRepository {
  final IGetGptWordsDatasource _datasource;
  GetGptWordsRepository(this._datasource);

  final _faker = Faker();

  @override
  Future<(GetWordsFailure?, List<WordEntity>)> getGptWords(GptRequestEntity word) async {
    try {
      final result = await _datasource.getGptWords(word.toModel());

      return (null, _parseResult(result));
    } on GetWordsFailure catch (e) {
      return (e, <WordEntity>[]);
    }
  }

  List<WordEntity> _parseResult(String result) =>
      List<WordEntity>.from(result.split(', ').map((e) => WordEntity(word: _wordTransformer(e), id: _faker.guid.guid())));

  String _wordTransformer(String word) => word.replaceFirst('-', ' ').replaceAll('.', '').capitalize();
}
