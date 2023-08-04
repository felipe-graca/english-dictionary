import 'package:english_dictionary/core/feature/word_signification/core/errors/word_signification_failure.dart';
import 'package:english_dictionary/core/feature/word_signification/data/datasource/get_word_signification/get_word_signification_datasource.dart';
import 'package:english_dictionary/core/feature/word_signification/data/repositories/get_word_signification/get_word_signification_repository.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/entities/signification_request_entity.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/repositories/get_word_signification/get_word_signification_repository_interface.dart';
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

  final wordSignificationEntity = WordSignificationEntity(
    word: word,
    pronunciation: '/kiː/ (keey)',
    definition: 'A key is a small, usually metal, instrument specifically cut to fit into a lock and move its bolt.',
    example: 'She misplaced her house key and couldn\'t get inside.',
  );

  const text =
      '''Example: She misplaced her house key and couldn't get inside.\n\nDefinition: A key is a small, usually metal, instrument specifically cut to fit into a lock and move its bolt.\n\nPronunciation: /kiː/ (keey)''';

  final significationRequest = SignificationRequestEntity(
    messages: [
      SignificationRequestMessageEntity(
          content:
              'Ineed that you return to me an example, definition an pronuciantion of word: [$word]. Your return need to be has this form: Example: [Your text]\n\nDefinition: [Your text]\n\nPronunciation: [Your text]. If this word does exists, your return has in one single line.',
          role: 'user')
    ],
  );

  test(
    'Shold return a Right WordSignificationModel',
    () async {
      when(datasource.getWordSignification(significationRequest.toModel())).thenAnswer((_) async => text);

      final (failure, result) = await repository.getWordSignification(word);

      expect(result, isA<WordSignificationEntity>());
      expect(result, wordSignificationEntity);
      expect(failure, isNull);

      verify(datasource.getWordSignification(significationRequest.toModel())).called(1);
      verifyNoMoreInteractions(datasource);
    },
  );

  test(
    'Shold return a Left GetWordSignificationFailure',
    () async {
      when(datasource.getWordSignification(significationRequest.toModel())).thenThrow(GetWordSignificationFailure());
      final (failure, result) = await repository.getWordSignification(word);

      expect(result, const WordSignificationEntity());
      expect(failure, isA<GetWordSignificationFailure>());

      verify(datasource.getWordSignification(significationRequest.toModel())).called(1);
      verifyNoMoreInteractions(datasource);
    },
  );
}
