import 'package:english_dictionary/core/feature/favorites/data/datasources/save_favorite_word/save_favorite_word_datasource.dart';
import 'package:english_dictionary/core/feature/favorites/data/repositories/save_favorite_word/save_favorite_word_repository.dart';
import 'package:english_dictionary/core/feature/favorites/domain/repositories/save_favorite_word/save_favorite_word_interface.dart';
import 'package:english_dictionary/core/feature/words/core/errors/words_failure.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'save_favorite_word_repository_test.mocks.dart';

@GenerateMocks([SaveFavoriteWordDatasource])
main() {
  final datasource = MockSaveFavoriteWordDatasource();
  final ISaveFavoriteWordRepository repository = SaveFavoriteWordRepository(datasource);

  final faker = Faker();

  final wordEntity = WordEntity(
    id: faker.guid.guid(),
    word: faker.lorem.word(),
  );

  test('should save favorite word', () async {
    when(datasource.saveFavoriteWord(any)).thenAnswer((_) async => wordEntity.toModel());

    final result = await repository.saveFavoriteWord(wordEntity);

    expect(result.isRight(), true);
  });

  test('should return a SaveFavoriteWordFailure when save favorite wordEntity', () async {
    when(datasource.saveFavoriteWord(wordEntity.toModel())).thenThrow(SaveFavoriteWordFailure());

    final result = await repository.saveFavoriteWord(wordEntity);

    expect(result.isLeft(), true);
    expect(result.fold((failure) => failure, (success) => success), isA<SaveFavoriteWordFailure>());
  });
}
