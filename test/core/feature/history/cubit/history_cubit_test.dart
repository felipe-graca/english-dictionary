import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/history/core/errors/hisotry_failure.dart';
import 'package:english_dictionary/core/feature/history/cubit/history_cubit.dart';
import 'package:english_dictionary/core/feature/history/domain/entities/history_word_entity.dart';
import 'package:english_dictionary/core/feature/history/domain/usecases/clear_history_word/clear_history_word_usecase.dart';
import 'package:english_dictionary/core/feature/history/domain/usecases/get_history_words/get_history_words_usecase.dart';
import 'package:english_dictionary/core/feature/history/domain/usecases/save_history_word/save_history_word_usecase.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'history_cubit_test.mocks.dart';

@GenerateMocks([
  GetHistoryWordsUsecase,
  ClearHistoryWordsUsecase,
  SaveHistoryWordUsecase,
])
main() {
  final saveHistoryWordUsecase = MockSaveHistoryWordUsecase();
  final getHistoryWordsUsecase = MockGetHistoryWordsUsecase();
  final clearHistoryWordsUsecase = MockClearHistoryWordsUsecase();

  final historyCubit = HistoryCubit(
    getHistoryWordsUsecase,
    clearHistoryWordsUsecase,
    saveHistoryWordUsecase,
  );

  final faker = Faker();

  final historyWord = HistoryWordEntity(id: faker.guid.guid(), word: faker.lorem.word());

  group(
    'getHistoryWords()',
    () {
      test(
        'should emit [HistoryState] with [wasSubmitted] = true when called',
        () async {
          when(getHistoryWordsUsecase.call(noParams)).thenAnswer((_) async => Right([historyWord]));

          historyCubit.getHistoryWords();

          expect(historyCubit.state, const HistoryState(wasSubmitted: true));
        },
      );

      test(
        'should emit [HistoryState] with [wasSubmitted] = false and [words] = [List<HistoryWordEntity>] when called',
        () async {
          when(getHistoryWordsUsecase.call(noParams)).thenAnswer((_) async => Right([historyWord]));

          await historyCubit.getHistoryWords();

          expect(
            historyCubit.state,
            const HistoryState(
              wasSubmitted: false,
            ),
          );
        },
      );

      test(
        'should emit [HistoryState] with [wasSubmitted] = false and [errorMessage] = [String] when called',
        () async {
          when(getHistoryWordsUsecase.call(noParams)).thenThrow(GetHistoryWordsFailure());

          await historyCubit.getHistoryWords();

          expect(
            historyCubit.state,
            const HistoryState(
              wasSubmitted: false,
              errorMessage: 'Something went wrong at get history words',
            ),
          );
        },
      );
    },
  );

  group(
    'clearHistoryWords()',
    () {
      test(
        'should emit [HistoryState] with [wasSubmitted] = true when called',
        () async {
          when(clearHistoryWordsUsecase.call(noParams)).thenAnswer((_) async => const Right(true));

          historyCubit.clearHistoryWords();

          expect(historyCubit.state, const HistoryState(wasSubmitted: true));
        },
      );

      test(
        'should emit [HistoryState] with [wasSubmitted] = false and [words] = [] when called',
        () async {
          when(clearHistoryWordsUsecase.call(noParams)).thenAnswer((_) async => const Right(true));

          await historyCubit.clearHistoryWords();

          expect(
            historyCubit.state,
            const HistoryState(
              wasSubmitted: false,
              words: [],
            ),
          );
        },
      );

      test(
        'should emit [HistoryState] with [wasSubmitted] = false and [errorMessage] = [String] when called',
        () async {
          when(clearHistoryWordsUsecase.call(noParams)).thenThrow(ClearHistoryWordsFailure());

          await historyCubit.clearHistoryWords();

          expect(
            historyCubit.state,
            const HistoryState(
              wasSubmitted: false,
              errorMessage: 'Something went wrong at clear history words',
            ),
          );
        },
      );
    },
  );

  group(
    'saveHistoryWord()',
    () {
      test(
        'should emit [HistoryState] with [wasSubmitted] = true when called',
        () async {
          when(saveHistoryWordUsecase.call(any)).thenAnswer((_) async => Right(historyWord));

          historyCubit.saveHistoryWord(historyWord);

          expect(historyCubit.state, const HistoryState(wasSubmitted: true));
        },
      );

      test(
        'should emit [HistoryState] with [wasSubmitted] = false and [words] = [] when called',
        () async {
          when(saveHistoryWordUsecase.call(any)).thenAnswer((_) async => Right(historyWord));

          await historyCubit.saveHistoryWord(historyWord);

          expect(historyCubit.state, const HistoryState(wasSubmitted: false));
          expect(historyCubit.state.words, [historyWord]);
        },
      );

      test(
        'should emit [HistoryState] with [wasSubmitted] = false and [errorMessage] = [String] when called',
        () async {
          when(saveHistoryWordUsecase.call(any)).thenThrow(SaveHistoryWordFailure());

          await historyCubit.saveHistoryWord(historyWord);

          expect(
            historyCubit.state,
            const HistoryState(
              wasSubmitted: false,
              errorMessage: 'Something went wrong at save history word',
            ),
          );
        },
      );
    },
  );
}
