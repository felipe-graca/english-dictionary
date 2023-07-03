import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/word_signification/core/errors/word_signification_failure.dart';
import 'package:english_dictionary/core/feature/word_signification/cubit/word_signification_cubit.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/entities/pronunciation_entity.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/entities/results_entity.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/entities/word_signification_entity.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/usecases/get_word_signification/get_word_signification_usecase_interface.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'word_signification_cubit_test.mocks.dart';

@GenerateMocks([IGetWordSignificationUsecase])
void main() {
  final mockGetWordSignificationUsecase = MockIGetWordSignificationUsecase();
  final wordSignificationCubit = WordSignificationCubit(mockGetWordSignificationUsecase);

  final faker = Faker();

  final String word = faker.lorem.word();

  final pronunciation = PronunciationEntity(
    all: faker.lorem.word(),
    noun: faker.lorem.word(),
    verb: faker.lorem.word(),
    adjective: faker.lorem.word(),
    adverb: faker.lorem.word(),
  );

  final wordSignification = WordSignificationEntity(
    word: word,
    results: const <ResultsEntity>[],
    pronunciation: pronunciation,
    frequency: 0.0,
  );

  group('getWordSignification()', () {
    test('should get word signification', () async {
      when(mockGetWordSignificationUsecase.call(word)).thenAnswer((_) async => Right(wordSignification));

      wordSignificationCubit.getWordSignification(word);

      await untilCalled(mockGetWordSignificationUsecase.call(word));
      verify(mockGetWordSignificationUsecase.call(word));

      expect(wordSignificationCubit.state.wordSignification, wordSignification);
    });

    test('should get word signification failure', () async {
      when(mockGetWordSignificationUsecase.call(word)).thenAnswer((_) async => Left(GetWordSignificationFailure()));

      wordSignificationCubit.getWordSignification(word);

      await untilCalled(mockGetWordSignificationUsecase.call(word));
      verify(mockGetWordSignificationUsecase.call(word));

      expect(wordSignificationCubit.state.failure, GetWordSignificationFailure());
    });
  });
}
