import 'package:english_dictionary/core/feature/favorites/data/datasources/remove_favorite_word/remove_favorite_word_datasource.dart';
import 'package:english_dictionary/core/feature/favorites/data/repositories/remove_favorite_word/remove_favorite_word_repository.dart';
import 'package:english_dictionary/core/feature/favorites/domain/repositories/remove_favorite_word/remove_favorite_word_repository_interface.dart';
import 'package:english_dictionary/core/feature/words/core/errors/words_failure.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'remove_favorite_word_repository_test.mocks.dart';

@GenerateMocks([RemoveFavoriteWordDatasource])
main() {
  final datasource = MockRemoveFavoriteWordDatasource();

  final IRemoveFavoriteWordRepository usecase = RemoveFavoriteWordRepository(datasource);

  final faker = Faker();

  final wordEntity = WordEntity(
    id: faker.guid.guid(),
    word: faker.lorem.word(),
  );

  test(
    'Should return a RemoveFavoriteWordFailure when not found words',
    () async {
      when(datasource.removeFavoriteWord(wordEntity.toModel())).thenThrow(RemoveFavoriteWordFailure());

      final result = await usecase.removeFavoriteWord(wordEntity);

      expect(result.isLeft(), true);
      expect(result.fold((failure) => failure, (success) => success), isA<RemoveFavoriteWordFailure>());
    },
  );

  test(
    'Should return a RemoveFavoriteWordFailure when not found words',
    () async {
      when(datasource.removeFavoriteWord(wordEntity.toModel())).thenAnswer((_) async => true);

      final result = await usecase.removeFavoriteWord(wordEntity);

      expect(result.isRight(), true);
      expect(result.fold((failure) => failure, (success) => success), isA<bool>());
    },
  );
}
