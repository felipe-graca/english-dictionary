import 'package:english_dictionary/core/feature/favorites/core/errors/favorites_failure.dart';
import 'package:english_dictionary/core/feature/favorites/data/datasources/remove_favorite_word/remove_favorite_word_datasource.dart';
import 'package:english_dictionary/core/feature/favorites/data/repositories/remove_favorite_word/remove_favorite_word_repository.dart';
import 'package:english_dictionary/core/feature/favorites/domain/entities/favorite_word_entity.dart';
import 'package:english_dictionary/core/feature/favorites/domain/repositories/remove_favorite_word/remove_favorite_word_repository_interface.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'remove_favorite_word_repository_test.mocks.dart';

@GenerateMocks([RemoveFavoriteWordDatasource])
main() {
  final datasource = MockRemoveFavoriteWordDatasource();

  final IRemoveFavoriteWordRepository repository = RemoveFavoriteWordRepository(datasource);

  final faker = Faker();

  final wordEntity = FavoriteWordEntity(
    id: faker.guid.guid(),
    word: faker.lorem.word(),
  );

  test(
    'Should return true when remove favorite word',
    () async {
      when(datasource.removeFavoriteWord(wordEntity.toModel())).thenAnswer((_) async => true);

      final (failure, result) = await repository.removeFavoriteWord(wordEntity);

      expect(result, true);
      expect(failure, null);
    },
  );

  test(
    'Should return a RemoveFavoriteWordFailure when not found words',
    () async {
      when(datasource.removeFavoriteWord(wordEntity.toModel())).thenThrow(RemoveFavoriteWordFailure());

      final (failure, result) = await repository.removeFavoriteWord(wordEntity);

      expect(result, false);
      expect(failure, isA<RemoveFavoriteWordFailure>());
    },
  );
}
