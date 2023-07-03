import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/errors/failure.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';

abstract interface class IGetWordsRepository {
  Future<Either<Failure, List<WordEntity>>> getWords();
}
