import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/history/core/errors/hisotry_failure.dart';
import 'package:english_dictionary/core/feature/history/domain/entities/history_word_entity.dart';

abstract interface class ISaveHistoryWordRepository {
  Future<Either<SaveHistoryWordFailure, HistoryWordEntity>> saveHistoryWord(HistoryWordEntity model);
}
