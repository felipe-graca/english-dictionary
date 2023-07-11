import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/favorites/core/errors/favorites_failure.dart';
import 'package:english_dictionary/core/feature/favorites/domain/entities/favorite_word_entity.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';

abstract interface class IGetFavoritesWordsUsecase implements UseCase<List<FavoriteWordEntity>, NoParams> {
  @override
  Future<Either<GetFavoritesWordsFailure, List<FavoriteWordEntity>>> call(noParams);
}
