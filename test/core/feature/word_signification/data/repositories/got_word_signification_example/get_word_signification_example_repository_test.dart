import 'package:english_dictionary/core/feature/word_signification/core/errors/word_signification_failure.dart';
import 'package:english_dictionary/core/feature/word_signification/data/datasource/get_word_signification/get_word_signification_datasource.dart';
import 'package:english_dictionary/core/feature/word_signification/data/repositories/get_word_signification_exemple/get_word_signification_exemple_repository.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/entities/exemple_entity.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/repositories/get_word_signification_exemple/get_word_signification_exemple_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_word_signification_example_repository_test.mocks.dart';

@GenerateMocks([GetWordSignificationDatasource])
void main() {
  final datasource = MockGetWordSignificationExampleDatasource();

  final IGetWordSignificationExampleRepository repository = GetWordSignificationExampleRepository(datasource);

  const exampleEntity = ExampleEntity(
    word: 'word',
    examples: ['examples'],
  );

  group('GetWordSignificationRepository', () {
    test('should be a IGetWordSignificationRepository', () async {
      when(datasource.getWordSignification(any)).thenAnswer((_) async => exampleEntity.toModel());

      final (failure, result) = await repository.getWordSignificationExamples('word');

      expect(result, isA<ExampleEntity>());
      expect(result, exampleEntity);
      expect(failure, isNull);

      verify(datasource.getWordSignification('word')).called(1);
      verifyNoMoreInteractions(datasource);
    });

    test('should return a GetWordSignificationExampleFailure when datasource throw a GetWordSignificationExampleFailure', () async {
      when(datasource.getWordSignification(any)).thenThrow(GetWordSignificationExampleFailure());

      final (failure, result) = await repository.getWordSignificationExamples('word');

      expect(result, ExampleEntity.empty());
      expect(failure, isA<GetWordSignificationExampleFailure>());

      verify(datasource.getWordSignification('word')).called(1);
      verifyNoMoreInteractions(datasource);
    });
  });
}
