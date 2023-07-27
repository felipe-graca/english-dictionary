import 'package:english_dictionary/core/feature/favorites/core/errors/favorites_failure.dart';
import 'package:english_dictionary/core/feature/favorites/data/repositories/save_favorite_word/save_favorite_word_repository.dart';
import 'package:english_dictionary/core/feature/favorites/domain/entities/favorite_word_entity.dart';
import 'package:english_dictionary/core/feature/favorites/domain/usecases/save_favorite_word/save_favorite_word_usecase.dart';
import 'package:english_dictionary/core/feature/favorites/domain/usecases/save_favorite_word/save_favorite_word_usecase_interface.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'save_favorite_word_usecase_test.mocks.dart';

@GenerateMocks([SaveFavoriteWordRepository])
void main() {
  final repository = MockSaveFavoriteWordRepository();

  final ISaveFavoriteWordUsecase usecase = SaveFavoriteWordUsecase(repository);

  final faker = Faker();

  final wordEntity = FavoriteWordEntity(
    id: faker.guid.guid(),
    word: faker.lorem.word(),
  );

  test('should save favorite word', () async {
    when(repository.saveFavoriteWord(any)).thenAnswer((_) async => (null, true));

    final (failure, result) = await usecase(wordEntity);

    expect(result, true);
    expect(failure, null);

    verify(repository.saveFavoriteWord(wordEntity)).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('should return a SaveFavoriteWordFailure when save favorite wordEntity', () async {
    when(repository.saveFavoriteWord(wordEntity)).thenAnswer((_) async => (SaveFavoriteWordFailure(), false));

    final (failure, result) = await usecase(wordEntity);

    expect(result, false);
    expect(failure, isA<SaveFavoriteWordFailure>());

    verify(repository.saveFavoriteWord(wordEntity)).called(1);
    verifyNoMoreInteractions(repository);
  });
}
