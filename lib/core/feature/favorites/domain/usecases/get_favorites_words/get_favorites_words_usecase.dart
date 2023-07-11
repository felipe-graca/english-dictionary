import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/favorites/core/errors/favorites_failure.dart';
import 'package:english_dictionary/core/feature/favorites/domain/entities/favorite_word_entity.dart';
import 'package:english_dictionary/core/feature/favorites/domain/repositories/get_favorites_words/get_favorites_words_repository_interface.dart';
import 'package:english_dictionary/core/feature/favorites/domain/usecases/get_favorites_words/get_favorites_words_usecase_interface.dart';

class GetFavoritesWordsUsecase implements IGetFavoritesWordsUsecase {
  final IGetFavoritesWordsRepository repository;

  GetFavoritesWordsUsecase(this.repository);

  @override
  Future<Either<GetFavoritesWordsFailure, List<FavoriteWordEntity>>> call(noParams) async {
    try {
      final result = await repository.getFavoritesWords();
      return result.fold((failure) => throw failure, (success) => Right(success));
    } on GetFavoritesWordsFailure catch (e) {
      return Left(e);
    }
  }
}
