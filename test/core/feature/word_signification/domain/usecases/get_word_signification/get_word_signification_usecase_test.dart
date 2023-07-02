import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/word_signification/core/errors/word_signification_failure.dart';
import 'package:english_dictionary/core/feature/word_signification/data/repositories/get_word_signification/get_word_signification_repository.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/entities/pronunciation_entity.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/entities/syllables_entity.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/entities/word_signification_entity.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/usecases/get_word_signification/get_word_signification_usecase.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/usecases/get_word_signification/get_word_signification_usecase_interface.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_word_signification_usecase_test.mocks.dart';

@GenerateMocks([GetWordSignificationRepository])
main() {
  final repository = MockGetWordSignificationRepository();
  final IGetWordSignificationUsecase usecase = GetWordSignificationUsecase(repository);

  final faker = Faker();

  final word = faker.lorem.word();

  final pronunciation = PronunciationEntity(
    all: faker.lorem.word(),
    noun: faker.lorem.word(),
    verb: faker.lorem.word(),
    adjective: faker.lorem.word(),
    adverb: faker.lorem.word(),
  );

  const syllables = SyllablesEntity(
    count: '1',
    list: <String>[''],
  );

  final wordSignification = WordSignificationEntity(
    word: faker.lorem.word(),
    pronunciation: pronunciation,
    results: const [],
    syllables: syllables,
  );

  test(
    'Shold return a Right WordSignificationEntity',
    () async {
      when(repository.getWordSignification(word)).thenAnswer((_) async => Right(wordSignification));
      final result = await usecase(word);

      final resultFolded = result.fold((failure) => failure, (success) => success);

      expect(wordSignification, resultFolded);
      expect(result, Right(wordSignification));
    },
  );

  test(
    'Shold return a Left GetWordSignificationFailure',
    () async {
      when(repository.getWordSignification(word)).thenAnswer((_) async => Left(GetWordSignificationFailure()));
      final result = await usecase(word);

      expect(result, isA<Left<GetWordSignificationFailure, WordSignificationEntity>>());
    },
  );
}
