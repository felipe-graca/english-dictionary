import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/words/core/errors/words_failure.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
import 'package:english_dictionary/core/feature/words/domain/repositories/get_favorites_words/get_favorites_words_repository_interface.dart';
import 'package:english_dictionary/core/feature/words/domain/usecases/get_favorites_words/get_favorites_words_usecase_interface.dart';

class GetFavoritesWordsUsecase implements IGetFavoritesWordsUsecase {
  final IGetFavoritesWordsRepository repository;

  GetFavoritesWordsUsecase(this.repository);

  @override
  Future<Either<GetFavoritesWordsFailure, List<WordEntity>>> call(noParams) async {
    try {
      final result = await repository.getFavoritesWords();
      return result.fold((failure) => throw failure, (success) => Right(success));
    } on GetFavoritesWordsFailure catch (e) {
      return Left(e);
    }
  }
}
