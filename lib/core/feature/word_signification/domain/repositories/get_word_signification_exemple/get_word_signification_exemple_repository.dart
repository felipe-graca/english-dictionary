import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/word_signification/core/errors/word_signification_failure.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/entities/exemple_entity.dart';

abstract interface class IGetWordSignificationExampleRepository {
  Future<Either<GetWordSignificationExampleFailure, ExampleEntity>> getWordSignificationExamples(String word);
}
