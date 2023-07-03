import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/words/core/errors/words_failure.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
import 'package:english_dictionary/core/feature/words/domain/repositories/get_words/get_words_repository_interface.dart';
import 'package:english_dictionary/core/feature/words/domain/usecases/get_words/get_words_usecase_interface.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';

class GetWordsUsecase implements IGetWordsUsecase {
  final IGetWordsRepository _repository;

  GetWordsUsecase(this._repository);

  @override
  Future<Either<GetWordsFailure, List<WordEntity>>> call(NoParams noParams) async {
    try {
      final result = await _repository.getWords();
      return result.fold((failure) => throw failure, (success) => Right(success));
    } on GetWordsFailure catch (e) {
      return Left(e);
    }
  }
}
