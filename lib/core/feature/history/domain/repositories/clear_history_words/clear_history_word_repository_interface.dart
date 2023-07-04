import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/history/core/errors/hisotry_failure.dart';

abstract interface class IClearHistoryWordRepository {
  Future<Either<ClearHistoryWordsFailure, bool>> clearHistoryWords();
}
