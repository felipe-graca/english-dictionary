import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/history/core/errors/hisotry_failure.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';

abstract interface class IClearHistoryWordsUsecase implements UseCase<bool, NoParams> {
  @override
  Future<Either<ClearHistoryWordsFailure, bool>> call(noParams);
}
