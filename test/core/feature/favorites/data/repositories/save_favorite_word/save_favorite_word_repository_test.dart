import 'package:english_dictionary/core/feature/favorites/core/errors/favorites_failure.dart';
import 'package:english_dictionary/core/feature/favorites/data/datasources/save_favorite_word/save_favorite_word_datasource.dart';
import 'package:english_dictionary/core/feature/favorites/data/repositories/save_favorite_word/save_favorite_word_repository.dart';
import 'package:english_dictionary/core/feature/favorites/domain/entities/favorite_word_entity.dart';
import 'package:english_dictionary/core/feature/favorites/domain/repositories/save_favorite_word/save_favorite_word_interface.dart';
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

  final wordEntity = FavoriteWordEntity(
    id: faker.guid.guid(),
    word: faker.lorem.word(),
  );

  test('should save favorite word', () async {
    when(datasource.saveFavoriteWord(any)).thenAnswer((_) async => true);

    final (failure, result) = await repository.saveFavoriteWord(wordEntity);

    expect(result, true);
    expect(failure, null);
  });

  test('should return a SaveFavoriteWordFailure when save favorite wordEntity', () async {
    when(datasource.saveFavoriteWord(wordEntity.toModel())).thenThrow(SaveFavoriteWordFailure());

    final (failure, result) = await repository.saveFavoriteWord(wordEntity);

    expect(result, false);
    expect(failure, isA<SaveFavoriteWordFailure>());
  });
}
