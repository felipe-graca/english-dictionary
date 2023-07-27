import 'package:english_dictionary/core/feature/word_signification/core/errors/word_signification_failure.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/entities/word_signification_entity.dart';

abstract interface class IGetWordSignificationRepository {
  Future<(GetWordSignificationFailure?, WordSignificationEntity)> getWordSignification(String word);
}
