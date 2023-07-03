import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/word_signification/core/errors/word_signification_failure.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/entities/exemple_entity.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';

abstract interface class IGetWordSignificationExampleUsecase implements UseCase<ExampleEntity, String> {
  @override
  Future<Either<GetWordSignificationExampleFailure, ExampleEntity>> call(String word);
}
