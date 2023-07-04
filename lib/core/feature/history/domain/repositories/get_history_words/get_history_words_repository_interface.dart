import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/history/core/errors/hisotry_failure.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';

abstract interface class IGetHistoryWordsRepository {
  Future<Either<GetHistoryWordsFailure, List<WordEntity>>> getHistoryWords();
}
