import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/favorites/core/errors/favorites_failure.dart';
import 'package:english_dictionary/core/feature/favorites/domain/entities/favorite_word_entity.dart';
import 'package:english_dictionary/core/feature/favorites/domain/repositories/save_favorite_word/save_favorite_word_interface.dart';
import 'package:english_dictionary/core/feature/favorites/domain/usecases/save_favorite_word/save_favorite_word_usecase_interface.dart';

class SaveFavoriteWordUsecase implements ISaveFavoriteWordUsecase {
  final ISaveFavoriteWordRepository _repository;

  SaveFavoriteWordUsecase(this._repository);

  @override
  Future<Either<SaveFavoriteWordFailure, FavoriteWordEntity>> call(FavoriteWordEntity model) async {
    try {
      final result = await _repository.saveFavoriteWord(model);
      return result.fold((failure) => Left(failure), (success) => Right(success));
    } on SaveFavoriteWordFailure catch (e) {
      return Left(e);
    }
  }
}
