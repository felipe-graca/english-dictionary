import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/words/core/errors/words_failure.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';

abstract interface class IRemoveFavoriteWordUsecase implements UseCase<bool, WordEntity> {
  @override
  Future<Either<RemoveFavoriteWordFailure, bool>> call(WordEntity model);
}
