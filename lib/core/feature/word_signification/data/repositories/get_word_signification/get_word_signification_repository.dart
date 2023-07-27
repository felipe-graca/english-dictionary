import 'package:english_dictionary/core/feature/word_signification/core/errors/word_signification_failure.dart';
import 'package:english_dictionary/core/feature/word_signification/data/datasource/get_word_signification/get_word_signification_datasource_interface.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/repositories/get_word_signification/get_word_signification_repository_interface.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/entities/word_signification_entity.dart';

class GetWordSignificationRepository implements IGetWordSignificationRepository {
  final IGetWordSignificationDatasource _datasource;

  GetWordSignificationRepository(this._datasource);

  @override
  Future<(GetWordSignificationFailure?, WordSignificationEntity)> getWordSignification(String word) async {
    try {
      return (null, (await _datasource.getWordSignification(word)).toEntity());
    } on GetWordSignificationFailure catch (e) {
      return (e, const WordSignificationEntity());
    }
  }
}
