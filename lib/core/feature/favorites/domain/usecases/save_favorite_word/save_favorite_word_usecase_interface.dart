import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/favorites/core/errors/favorites_failure.dart';
import 'package:english_dictionary/core/feature/favorites/domain/entities/favorite_word_entity.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';

abstract interface class ISaveFavoriteWordUsecase implements UseCase<FavoriteWordEntity, FavoriteWordEntity> {
  @override
  Future<Either<SaveFavoriteWordFailure, FavoriteWordEntity>> call(FavoriteWordEntity model);
}
