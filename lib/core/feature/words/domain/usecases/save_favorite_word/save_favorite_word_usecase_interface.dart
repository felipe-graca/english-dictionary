import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/words/core/errors/words_failure.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';

abstract interface class ISaveFavoriteWordUsecase implements UseCase<WordEntity, WordEntity> {
  @override
  Future<Either<SaveFavoriteWordFailure, WordEntity>> call(WordEntity model);
}
