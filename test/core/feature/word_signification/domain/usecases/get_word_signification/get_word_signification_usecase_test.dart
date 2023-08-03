import 'package:english_dictionary/core/feature/word_signification/core/errors/word_signification_failure.dart';
import 'package:english_dictionary/core/feature/word_signification/data/repositories/get_word_signification/get_word_signification_repository.dart';
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

  final wordSignificationEntity = WordSignificationEntity(
    word: word,
    pronunciation: '/kiː/ (keey)',
    definition: 'A key is a small, usually metal, instrument specifically cut to fit into a lock and move its bolt.',
    example: 'She misplaced her house key and couldn\'t get inside.',
  );

  test(
    'Shold return a Right WordSignificationEntity',
    () async {
      when(repository.getWordSignification(word)).thenAnswer((_) async => (null, wordSignificationEntity));
      final (failure, result) = await usecase.call(word);

      expect(result, isA<WordSignificationEntity>());
      expect(result, wordSignificationEntity);
      expect(failure, isNull);

      verify(repository.getWordSignification(word)).called(1);
      verifyNoMoreInteractions(repository);
    },
  );

  test(
    'Shold return a Left GetWordSignificationFailure',
    () async {
      when(repository.getWordSignification(word)).thenAnswer((_) async => (GetWordSignificationFailure(), const WordSignificationEntity()));

      final (failure, result) = await usecase.call(word);

      expect(result, const WordSignificationEntity());
      expect(failure, isA<GetWordSignificationFailure>());

      verify(repository.getWordSignification(word)).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
