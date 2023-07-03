import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/word_signification/core/errors/word_signification_failure.dart';
import 'package:english_dictionary/core/feature/word_signification/data/datasource/get_word_signification_exemple/get_word_signification_exemple_datasource_interface.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/entities/exemple_entity.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/repositories/get_word_signification_exemple/get_word_signification_exemple_repository.dart';

class GetWordSignificationExampleRepository implements IGetWordSignificationExampleRepository {
  final IGetWordSignificationExampleDatasource datasource;

  GetWordSignificationExampleRepository(this.datasource);

  @override
  Future<Either<GetWordSignificationExampleFailure, ExampleEntity>> getWordSignificationExamples(String word) async {
    try {
      final result = await datasource.getWordSignificationExamples(word);
      return right(result.toEntity());
    } on GetWordSignificationExampleFailure catch (e) {
      return left(e);
    }
  }
}
