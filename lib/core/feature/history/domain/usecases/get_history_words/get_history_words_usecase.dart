import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/history/core/errors/hisotry_failure.dart';
import 'package:english_dictionary/core/feature/history/domain/repositories/get_history_words/get_history_words_repository_interface.dart';
import 'package:english_dictionary/core/feature/history/domain/usecases/get_history_words/get_history_words_usecase_interface.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';

class GetHistoryWordsUsecase implements IGetHistoryWordsUsecase {
  final IGetHistoryWordsRepository repository;

  GetHistoryWordsUsecase(this.repository);

  @override
  Future<Either<GetHistoryWordsFailure, List<WordEntity>>> call(noParams) async {
    try {
      final result = await repository.getHistoryWords();
      return result.fold((failure) => throw failure, (success) => Right(success));
    } on GetHistoryWordsFailure catch (e) {
      return Left(e);
    }
  }
}
