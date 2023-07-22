import 'package:english_dictionary/core/feature/word_signification/core/errors/word_signification_failure.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/entities/word_signification_entity.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';

abstract interface class IGetWordSignificationUsecase extends UseCase<WordSignificationEntity, String> {
  @override
  Future<(GetWordSignificationFailure?, WordSignificationEntity)> call(String params);
}
