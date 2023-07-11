import 'package:dartz/dartz.dart';
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
    when(repository.removeFavoriteWord(wordEntity)).thenAnswer((_) async => const Right(true));
    final result = await usecase(wordEntity);
    expect(result.isRight(), true);
  });

  test('should return a RemoveFavoriteWordFailure when remove favorite wordEntity', () async {
    when(repository.removeFavoriteWord(wordEntity)).thenAnswer((_) async => Left(RemoveFavoriteWordFailure()));
    final result = await usecase(wordEntity);
    expect(result.isLeft(), true);
    expect(result.fold((failure) => failure, (success) => success), isA<RemoveFavoriteWordFailure>());
  });
}
