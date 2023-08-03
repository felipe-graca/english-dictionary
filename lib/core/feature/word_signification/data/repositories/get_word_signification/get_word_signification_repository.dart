import 'package:english_dictionary/core/errors/gpt_failure.dart';
import 'package:english_dictionary/core/feature/word_signification/core/errors/word_signification_failure.dart';
import 'package:english_dictionary/core/feature/word_signification/data/datasource/get_word_signification/get_word_signification_datasource_interface.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/entities/signification_request_entity.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/entities/word_signification_entity.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/repositories/get_word_signification/get_word_signification_repository_interface.dart';

class GetWordSignificationRepository implements IGetWordSignificationRepository {
  final IGetWordSignificationDatasource _datasource;

  GetWordSignificationRepository(this._datasource);

  @override
  Future<(GetWordSignificationFailure?, WordSignificationEntity)> getWordSignification(String word) async {
    try {
      return (null, _buildWordSignificationEntity(await _datasource.getWordSignification(_buildRequestEntity(word).toModel()), word));
    } on GetWordSignificationFailure catch (e) {
      return (e, const WordSignificationEntity());
    } on GptFailure {
      return getWordSignification(word);
    }
  }

  SignificationRequestEntity _buildRequestEntity(String word) {
    return SignificationRequestEntity(
      messages: [SignificationRequestMessageEntity(content: _builAIString(word), role: 'user')],
    );
  }

  WordSignificationEntity _buildWordSignificationEntity(String message, String word) {
    final results = message.split('\n\n');
    try {
      return WordSignificationEntity(
        example: results[0].replaceRange(0, 'Example: '.length, ''),
        definition: results[1].replaceRange(0, 'Definition: '.length, ''),
        pronunciation: results[2].replaceRange(0, 'Pronunciation :'.length, ''),
        word: word,
      );
    } catch (e) {
      if (results.length == 1) throw GetWordSignificationFailure(message: results[0]);
      throw GptFailure();
    }
  }

  String _builAIString(String text) {
    return "Ineed that you return to me an example, definition an pronuciantion of word: [$text]. Your return need to be has this form: Example: [Your text]\n\nDefinition: [Your text]\n\nPronunciation: [Your text]. If this word does exists, your return has in one single line.";
  }
}
