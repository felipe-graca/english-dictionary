import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/words/core/errors/words_failure.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
import 'package:english_dictionary/core/feature/words/domain/repositories/remove_favorite_word/remove_favorite_word_repository_interface.dart';
import 'package:english_dictionary/core/feature/words/domain/usecases/remove_favorite_word/remove_favorite_word_usecase_interface.dart';

class RemoveFavoriteWordUsecase implements IRemoveFavoriteWordUsecase {
  final IRemoveFavoriteWordRepository repository;

  RemoveFavoriteWordUsecase(this.repository);

  @override
  Future<Either<RemoveFavoriteWordFailure, bool>> call(WordEntity model) async {
    return await repository.removeFavoriteWord(model);
  }
}
