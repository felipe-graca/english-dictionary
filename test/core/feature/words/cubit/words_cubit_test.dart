import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/words/core/errors/words_failure.dart';
import 'package:english_dictionary/core/feature/words/cubit/words_cubit.dart';
import 'package:english_dictionary/core/feature/words/domain/usecases/get_words/get_words_usecase.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'words_cubit_test.mocks.dart';

@GenerateMocks([GetWordsUsecase])
main() {
  final mockGetWordsUsecase = MockGetWordsUsecase();

  final wordsCubit = WordsCubit(mockGetWordsUsecase);

  group('getWords()', () {
    test('should get words', () async {
      when(mockGetWordsUsecase.call(noParams)).thenAnswer((_) async => const Right([]));

      wordsCubit.getWords();

      await untilCalled(mockGetWordsUsecase.call(noParams));
      verify(mockGetWordsUsecase.call(noParams));

      expect(wordsCubit.state.words, []);
    });

    test('should get words failure', () async {
      when(mockGetWordsUsecase.call(noParams)).thenAnswer((_) async => Left(GetWordsFailure()));

      await wordsCubit.getWords();

      await untilCalled(mockGetWordsUsecase.call(noParams));
      verify(mockGetWordsUsecase.call(noParams));

      expect(wordsCubit.state.errorMessage, GetWordsFailure().message);
    });
  });
}
