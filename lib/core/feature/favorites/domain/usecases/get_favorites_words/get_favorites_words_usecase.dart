import 'package:english_dictionary/core/feature/favorites/core/errors/favorites_failure.dart';
import 'package:english_dictionary/core/feature/favorites/domain/entities/favorite_word_entity.dart';
import 'package:english_dictionary/core/feature/favorites/domain/repositories/get_favorites_words/get_favorites_words_repository_interface.dart';
import 'package:english_dictionary/core/feature/favorites/domain/usecases/get_favorites_words/get_favorites_words_usecase_interface.dart';

class GetFavoritesWordsUsecase implements IGetFavoritesWordsUsecase {
  final IGetFavoritesWordsRepository _repository;

  GetFavoritesWordsUsecase(this._repository);

  @override
  Future<(GetFavoritesWordsFailure?, List<FavoriteWordEntity>)> call(noParams) async => await _repository.getFavoritesWords();
}
