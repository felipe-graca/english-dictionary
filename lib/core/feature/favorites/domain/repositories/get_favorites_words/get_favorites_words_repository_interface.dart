import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/words/core/errors/words_failure.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';

abstract interface class IGetFavoritesWordsRepository {
  Future<Either<GetFavoritesWordsFailure, List<WordEntity>>> getFavoritesWords();
}
