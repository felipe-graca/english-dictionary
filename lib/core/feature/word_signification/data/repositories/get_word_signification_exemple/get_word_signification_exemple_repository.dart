import 'package:english_dictionary/core/feature/word_signification/core/errors/word_signification_failure.dart';
import 'package:english_dictionary/core/feature/word_signification/data/datasource/get_word_signification_exemple/get_word_signification_exemple_datasource_interface.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/entities/exemple_entity.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/repositories/get_word_signification_exemple/get_word_signification_exemple_repository.dart';

class GetWordSignificationExampleRepository implements IGetWordSignificationExampleRepository {
  final IGetWordSignificationExampleDatasource _datasource;

  GetWordSignificationExampleRepository(this._datasource);

  @override
  Future<(GetWordSignificationExampleFailure?, ExampleEntity)> getWordSignificationExamples(String word) async {
    try {
      return (null, (await _datasource.getWordSignificationExamples(word)).toEntity());
    } on GetWordSignificationExampleFailure catch (e) {
      return (e, const ExampleEntity());
    }
  }
}
