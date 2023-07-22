import 'package:english_dictionary/core/feature/history/core/errors/hisotry_failure.dart';

abstract interface class IClearHistoryWordRepository {
  Future<(ClearHistoryWordsFailure?, bool)> clearHistoryWords();
}
