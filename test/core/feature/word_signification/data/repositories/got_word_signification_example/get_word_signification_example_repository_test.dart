import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/word_signification/core/errors/word_signification_failure.dart';
import 'package:english_dictionary/core/feature/word_signification/data/datasource/get_word_signification_exemple/get_word_signification_exemple_datasource.dart';
import 'package:english_dictionary/core/feature/word_signification/data/repositories/get_word_signification_exemple/get_word_signification_exemple_repository.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/entities/exemple_entity.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/repositories/get_word_signification_exemple/get_word_signification_exemple_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_word_signification_example_repository_test.mocks.dart';

@GenerateMocks([GetWordSignificationExampleDatasource])
void main() {
  final datasource = MockGetWordSignificationExampleDatasource();

  final IGetWordSignificationExampleRepository repository = GetWordSignificationExampleRepository(datasource);

  const exampleEntity = ExampleEntity(
    word: 'word',
    examples: ['examples'],
  );

  group('GetWordSignificationRepository', () {
    test('should be a IGetWordSignificationRepository', () async {
      when(datasource.getWordSignificationExamples(any)).thenAnswer((_) async => exampleEntity.toModel());

      final result = await repository.getWordSignificationExamples('word');

      expect(result, isA<Right<GetWordSignificationExampleFailure, ExampleEntity>>());
    });

    test('should return a GetWordSignificationExampleFailure when datasource throw a GetWordSignificationExampleFailure', () async {
      when(datasource.getWordSignificationExamples(any)).thenThrow(GetWordSignificationExampleFailure());

      final result = await repository.getWordSignificationExamples('word');

      expect(result, isA<Left<GetWordSignificationExampleFailure, ExampleEntity>>());
    });
  });
}
