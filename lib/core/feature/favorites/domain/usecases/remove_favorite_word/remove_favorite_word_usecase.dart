import 'package:english_dictionary/core/feature/favorites/core/errors/favorites_failure.dart';
import 'package:english_dictionary/core/feature/favorites/domain/entities/favorite_word_entity.dart';
import 'package:english_dictionary/core/feature/favorites/domain/repositories/remove_favorite_word/remove_favorite_word_repository_interface.dart';
import 'package:english_dictionary/core/feature/favorites/domain/usecases/remove_favorite_word/remove_favorite_word_usecase_interface.dart';

class RemoveFavoriteWordUsecase implements IRemoveFavoriteWordUsecase {
  final IRemoveFavoriteWordRepository _repository;

  RemoveFavoriteWordUsecase(this._repository);

  @override
  Future<(RemoveFavoriteWordFailure?, bool)> call(FavoriteWordEntity entity) async => await _repository.removeFavoriteWord(entity);
}
