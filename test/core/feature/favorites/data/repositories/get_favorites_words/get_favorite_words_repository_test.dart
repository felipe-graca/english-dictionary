import 'package:english_dictionary/core/feature/favorites/data/datasources/get_favorites_words/get_favorites_words_datasource.dart';
import 'package:english_dictionary/core/feature/favorites/data/repositories/get_favorites_words/get_favorites_words_repository.dart';
import 'package:english_dictionary/core/feature/favorites/domain/repositories/get_favorites_words/get_favorites_words_repository_interface.dart';
import 'package:english_dictionary/core/feature/words/core/errors/words_failure.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_favorite_words_repository_test.mocks.dart';

@GenerateMocks([GetFavoritesWordsDatasource])
main() {
  final datasource = MockGetFavoritesWordsDatasource();
  final IGetFavoritesWordsRepository usecase = GetFavoritesWordsRepository(datasource);

  final faker = Faker();

  final wordEntity = WordEntity(
    id: faker.guid.guid(),
    word: faker.lorem.word(),
  );

  test(
    'Should return a list of words entity',
    () async {
      when(datasource.getFavoritesWords()).thenAnswer((_) async => [wordEntity.toModel()]);

      final result = await usecase.getFavoritesWords();

      expect(result.isRight(), true);
      expect(result.fold((failure) => failure, (success) => success), isA<List<WordEntity>>());
    },
  );

  test(
    'Should return a GetFavoritesWordsFailure when not found words',
    () async {
      when(datasource.getFavoritesWords()).thenThrow(GetFavoritesWordsFailure());

      final result = await usecase.getFavoritesWords();

      expect(result.isLeft(), true);
      expect(result.fold((failure) => failure, (success) => success), isA<GetFavoritesWordsFailure>());
    },
  );
}
