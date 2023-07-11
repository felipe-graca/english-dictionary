import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/history/core/errors/hisotry_failure.dart';
import 'package:english_dictionary/core/feature/history/domain/entities/history_word_entity.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';

abstract interface class ISaveHistoryWordUsecase implements UseCase<HistoryWordEntity, HistoryWordEntity> {
  @override
  Future<Either<SaveHistoryWordFailure, HistoryWordEntity>> call(entity);
}
