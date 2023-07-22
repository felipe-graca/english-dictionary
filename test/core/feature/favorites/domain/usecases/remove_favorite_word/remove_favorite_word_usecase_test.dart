import 'package:english_dictionary/core/feature/favorites/core/errors/favorites_failure.dart';
import 'package:english_dictionary/core/feature/favorites/data/repositories/remove_favorite_word/remove_favorite_word_repository.dart';
import 'package:english_dictionary/core/feature/favorites/domain/entities/favorite_word_entity.dart';
import 'package:english_dictionary/core/feature/favorites/domain/usecases/remove_favorite_word/remove_favorite_word_usecase.dart';
import 'package:english_dictionary/core/feature/favorites/domain/usecases/remove_favorite_word/remove_favorite_word_usecase_interface.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'remove_favorite_word_usecase_test.mocks.dart';

@GenerateMocks([RemoveFavoriteWordRepository])
void main() {
  final repository = MockRemoveFavoriteWordRepository();

  final IRemoveFavoriteWordUsecase usecase = RemoveFavoriteWordUsecase(repository);

  final faker = Faker();

  final wordEntity = FavoriteWordEntity(
    id: faker.guid.guid(),
    word: faker.lorem.word(),
  );

  test('should remove favorite word', () async {
    when(repository.removeFavoriteWord(wordEntity)).thenAnswer((_) async => (null, true));

    final (failure, result) = await usecase.call(wordEntity);

    expect(result, true);
    expect(failure, null);

    verify(repository.removeFavoriteWord(wordEntity)).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('should return a RemoveFavoriteWordFailure when remove favorite wordEntity', () async {
    when(repository.removeFavoriteWord(wordEntity)).thenAnswer((_) async => (RemoveFavoriteWordFailure(), false));

    final (failure, result) = await usecase.call(wordEntity);

    expect(result, false);
    expect(failure, isA<RemoveFavoriteWordFailure>());

    verify(repository.removeFavoriteWord(wordEntity)).called(1);
    verifyNoMoreInteractions(repository);
  });
}
