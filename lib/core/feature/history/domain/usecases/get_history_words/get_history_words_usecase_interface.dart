import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/history/core/errors/hisotry_failure.dart';
import 'package:english_dictionary/core/feature/history/domain/entities/history_word_entity.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';

abstract interface class IGetHistoryWordsUsecase implements UseCase<List<HistoryWordEntity>, NoParams> {
  @override
  Future<Either<GetHistoryWordsFailure, List<HistoryWordEntity>>> call(noParams);
}
