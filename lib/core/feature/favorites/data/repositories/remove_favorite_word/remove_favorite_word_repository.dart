import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/favorites/core/errors/favorites_failure.dart';
import 'package:english_dictionary/core/feature/favorites/data/datasources/remove_favorite_word/remove_favorite_word_datasource_interface.dart';
import 'package:english_dictionary/core/feature/favorites/domain/entities/favorite_word_entity.dart';
import 'package:english_dictionary/core/feature/favorites/domain/repositories/remove_favorite_word/remove_favorite_word_repository_interface.dart';

class RemoveFavoriteWordRepository implements IRemoveFavoriteWordRepository {
  final IRemoveFavoriteWordDatasource _datasource;

  RemoveFavoriteWordRepository(this._datasource);

  @override
  Future<Either<RemoveFavoriteWordFailure, bool>> removeFavoriteWord(FavoriteWordEntity entity) async {
    try {
      final result = await _datasource.removeFavoriteWord(entity.toModel());
      return Right(result);
    } on RemoveFavoriteWordFailure catch (e) {
      return Future.value(Left(e));
    }
  }
}
