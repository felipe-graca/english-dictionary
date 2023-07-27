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
  final clearHistoryWordsDataSource = MockClearHistoryWordsDatasource();

  final IClearHistoryWordRepository clearHistoryWordRepository = ClearHistoryWordRepository(clearHistoryWordsDataSource);

  group(
    'clearHistoryWords()',
    () {
      test(
        'should return [Right(true)] when [ClearHistoryWordsDatasource.clearHistoryWords()] return [true]',
        () async {
          when(clearHistoryWordsDataSource.clearHistoryWords()).thenAnswer((_) async => true);

          final (failure, result) = await clearHistoryWordRepository.clearHistoryWords();

          expect(result, true);
          expect(failure, isNull);

          verify(clearHistoryWordsDataSource.clearHistoryWords()).called(1);
          verifyNoMoreInteractions(clearHistoryWordsDataSource);
        },
      );

      test(
        'should return [Left(ClearHistoryWordsFailure())] when [ClearHistoryWordsDatasource.clearHistoryWords()] throw [ClearHistoryWordsFailure()]',
        () async {
          when(clearHistoryWordsDataSource.clearHistoryWords()).thenThrow(ClearHistoryWordsFailure());

          final (failure, result) = await clearHistoryWordRepository.clearHistoryWords();

          expect(result, false);
          expect(failure, isA<ClearHistoryWordsFailure>());

          verify(clearHistoryWordsDataSource.clearHistoryWords()).called(1);
        },
      );
    },
  );
}
