import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/history/core/errors/hisotry_failure.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';

abstract interface class ISaveHistoryWordsUsecase implements UseCase<WordEntity, WordEntity> {
  @override
  Future<Either<SaveHistoryWordFailure, WordEntity>> call(WordEntity model);
}
