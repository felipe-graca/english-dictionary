import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/word_signification/core/errors/word_signification_failure.dart';
import 'package:english_dictionary/core/feature/word_signification/data/datasource/get_word_signification/get_word_signification_datasource.dart';
import 'package:english_dictionary/core/feature/word_signification/data/repositories/get_word_signification/get_word_signification_repository.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/repositories/get_word_signification/get_word_signification_trpository_interface.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/entities/pronunciation_entity.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/entities/results_entity.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/entities/syllables_entity.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/entities/word_signification_entity.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_word_signification_repository_test.mocks.dart';

@GenerateMocks([GetWordSignificationDatasource])
main() {
  final datasource = MockGetWordSignificationDatasource();
  final IGetWordSignificationRepository repository = GetWordSignificationRepository(datasource);

  final faker = Faker();
  final word = faker.lorem.word();

  final pronunciationEntity = PronunciationEntity(
    all: faker.lorem.word(),
    noun: faker.lorem.word(),
    verb: faker.lorem.word(),
    adjective: faker.lorem.word(),
    adverb: faker.lorem.word(),
  );

  const syllablesEntity = SyllablesEntity(
    count: 1,
    list: <String>[''],
  );

  final wordSignificationEntity = WordSignificationEntity(
    word: faker.lorem.word(),
    pronunciation: pronunciationEntity,
    results: const <ResultsEntity>[],
    syllables: syllablesEntity,
  );

  test(
    'Shold return a Right WordSignificationModel',
    () async {
      when(datasource.getWordSignification(word)).thenAnswer((_) async => wordSignificationEntity.toModel());
      final result = await repository.getWordSignification(word);

      expect(result, Right(wordSignificationEntity));
    },
  );

  test(
    'Shold return a Left GetWordSignificationFailure',
    () async {
      when(datasource.getWordSignification(word)).thenThrow(GetWordSignificationFailure());
      final result = await repository.getWordSignification(word);

      expect(result, isA<Left<GetWordSignificationFailure, WordSignificationEntity>>());
    },
  );
}
