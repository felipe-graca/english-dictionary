import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/history/core/errors/hisotry_failure.dart';
import 'package:english_dictionary/core/feature/history/data/datasources/clear_history_words/clear_history_words_datasource.dart';
import 'package:english_dictionary/core/feature/history/data/repositories/clear_history_worda/clear_history_words_repository.dart';
import 'package:english_dictionary/core/feature/history/domain/repositories/clear_history_words/clear_history_word_repository_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'clear_history_words_repository_test.mocks.dart';

@GenerateMocks([ClearHistoryWordsDatasource])
main() {
  final clearHistoryWordsUsecase = MockClearHistoryWordsDatasource();

  final IClearHistoryWordRepository clearHistoryWordRepository = ClearHistoryWordRepository(clearHistoryWordsUsecase);

  group(
    'clearHistoryWords()',
    () {
      test(
        'should return [Right(true)] when [ClearHistoryWordsDatasource.clearHistoryWords()] return [true]',
        () async {
          when(clearHistoryWordsUsecase.clearHistoryWords()).thenAnswer((_) async => true);

          final result = await clearHistoryWordRepository.clearHistoryWords();

          expect(result, const Right(true));
        },
      );

      test(
        'should return [Left(ClearHistoryWordsFailure())] when [ClearHistoryWordsDatasource.clearHistoryWords()] throw [ClearHistoryWordsFailure()]',
        () async {
          when(clearHistoryWordsUsecase.clearHistoryWords()).thenThrow(ClearHistoryWordsFailure());

          final result = await clearHistoryWordRepository.clearHistoryWords();

          expect(result, isA<Left<ClearHistoryWordsFailure, bool>>());
        },
      );
    },
  );
}
