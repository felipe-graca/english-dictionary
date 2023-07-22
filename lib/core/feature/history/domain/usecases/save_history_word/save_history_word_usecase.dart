import 'package:english_dictionary/core/feature/history/core/errors/hisotry_failure.dart';
import 'package:english_dictionary/core/feature/history/domain/entities/history_word_entity.dart';
import 'package:english_dictionary/core/feature/history/domain/repositories/save_history_word/save_history_word_interface.dart';
import 'package:english_dictionary/core/feature/history/domain/usecases/save_history_word/save_history_word_usecase_interface.dart';

class SaveHistoryWordUsecase implements ISaveHistoryWordUsecase {
  final ISaveHistoryWordRepository _repository;

  SaveHistoryWordUsecase(this._repository);

  @override
  Future<(SaveHistoryWordFailure?, bool)> call(HistoryWordEntity entity) async => await _repository.saveHistoryWord(entity);
}
