import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/history/core/errors/hisotry_failure.dart';
import 'package:english_dictionary/core/feature/history/data/repositories/clear_history_worda/clear_history_words_repository.dart';
import 'package:english_dictionary/core/feature/history/domain/usecases/clear_history_word/clear_history_word_usecase.dart';
import 'package:english_dictionary/core/feature/history/domain/usecases/clear_history_word/clear_history_word_usecase_interface.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'clear_history_words_usecase_test.mocks.dart';

@GenerateMocks([ClearHistoryWordRepository])
main() {
  final clearHistoryWordRepository = MockClearHistoryWordRepository();

  final IClearHistoryWordsUsecase clearHistoryWordsUsecase = ClearHistoryWordsUsecase(clearHistoryWordRepository);

  group(
    'ClearHistoryWordsUsecase',
    () {
      test(
        'should return [Right(true)] when [ClearHistoryWordRepository.clearHistoryWords()] return [Right(true)]',
        () async {
          when(clearHistoryWordRepository.clearHistoryWords()).thenAnswer((_) async => const Right(true));

          final result = await clearHistoryWordsUsecase.call(noParams);

          expect(result, const Right(true));
        },
      );

      test(
        'should return [Left(ClearHistoryWordsFailure())] when [ClearHistoryWordRepository.clearHistoryWords()] throw [ClearHistoryWordsFailure()]',
        () async {
          when(clearHistoryWordRepository.clearHistoryWords()).thenThrow(ClearHistoryWordsFailure());

          final result = await clearHistoryWordsUsecase.call(noParams);

          expect(result, isA<Left<ClearHistoryWordsFailure, bool>>());
        },
      );
    },
  );
}
