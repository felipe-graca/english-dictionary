import 'package:english_dictionary/core/feature/word_signification/core/errors/word_signification_failure.dart';
import 'package:english_dictionary/core/feature/word_signification/data/repositories/get_word_signification_exemple/get_word_signification_exemple_repository.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/entities/exemple_entity.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/usecases/get_word_signification_exemple/get_word_signification_exemple_usecase.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/usecases/get_word_signification_exemple/get_word_signification_exemple_usecase_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_word_signification_usecase_test.mocks.dart';

@GenerateMocks([GetWordSignificationExampleRepository])
main() {
  final repository = MockGetWordSignificationExampleRepository();
  final IGetWordSignificationExampleUsecase usecase = GetWordSignificationExampleUsecase(repository);

  const exampleEntity = ExampleEntity(
    word: 'word',
    examples: ['examples'],
  );

  group(
    'Should be return exampleEntity when call getWordSignificationExample',
    () {
      test('should be return exampleEntity when call getWordSignificationExample', () async {
        when(repository.getWordSignificationExamples(any)).thenAnswer((_) async => (null, exampleEntity));

        final (failure, result) = await usecase.call('word');

        expect(result, isA<ExampleEntity>());
        expect(result, exampleEntity);
        expect(failure, isNull);

        verify(repository.getWordSignificationExamples('word')).called(1);
        verifyNoMoreInteractions(repository);
      });

      test('should be return GetWordSignificationExampleFailure when call getWordSignificationExample', () async {
        when(repository.getWordSignificationExamples(any)).thenAnswer((_) async => (GetWordSignificationExampleFailure(), const ExampleEntity()));

        final (failure, result) = await usecase.call('word');

        expect(result, ExampleEntity.empty());
        expect(failure, isA<GetWordSignificationExampleFailure>());

        verify(repository.getWordSignificationExamples('word')).called(1);
        verifyNoMoreInteractions(repository);
      });
    },
  );
}
