import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/history/core/errors/hisotry_failure.dart';
import 'package:english_dictionary/core/feature/history/domain/entities/history_word_entity.dart';
import 'package:english_dictionary/core/feature/history/domain/repositories/save_history_word/save_history_word_interface.dart';
import 'package:english_dictionary/core/feature/history/domain/usecases/save_history_word/save_history_word_usecase_interface.dart';

class SaveHistoryWordUsecase implements ISaveHistoryWordsUsecase {
  final ISaveHistoryWordRepository _repository;

  SaveHistoryWordUsecase(this._repository);

  @override
  Future<Either<SaveHistoryWordFailure, HistoryWordEntity>> call(HistoryWordEntity entity) async {
    try {
      final result = await _repository.saveHistoryWord(entity);
      return result.fold((failure) => Left(failure), (success) => Right(success));
    } on SaveHistoryWordFailure catch (e) {
      return Left(e);
    }
  }
}
