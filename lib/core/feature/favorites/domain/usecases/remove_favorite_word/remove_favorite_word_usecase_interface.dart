import 'package:english_dictionary/core/feature/favorites/core/errors/favorites_failure.dart';
import 'package:english_dictionary/core/feature/favorites/domain/entities/favorite_word_entity.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';

abstract interface class IRemoveFavoriteWordUsecase implements UseCase<bool, FavoriteWordEntity> {
  @override
  Future<(RemoveFavoriteWordFailure?, bool)> call(entity);
}
