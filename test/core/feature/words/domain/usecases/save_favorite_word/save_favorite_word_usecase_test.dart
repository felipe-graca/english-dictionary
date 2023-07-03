import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/words/core/errors/words_failure.dart';
import 'package:english_dictionary/core/feature/words/data/repositories/save_favorite_word/save_favorite_word_repository.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
import 'package:english_dictionary/core/feature/words/domain/usecases/save_favorite_word/save_favorite_word_usecase.dart';
import 'package:english_dictionary/core/feature/words/domain/usecases/save_favorite_word/save_favorite_word_usecase_interface.dart';
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

  final wordEntity = WordEntity(
    id: faker.guid.guid(),
    word: faker.lorem.word(),
  );

  test('should save favorite word', () async {
    when(repository.saveFavoriteWord(any)).thenAnswer((_) async => Right(wordEntity));

    final result = await usecase(wordEntity);

    expect(result.isRight(), true);
  });

  test('should return a SaveFavoriteWordFailure when save favorite wordEntity', () async {
    when(repository.saveFavoriteWord(wordEntity)).thenAnswer((_) async => Left(SaveFavoriteWordFailure()));

    final result = await usecase(wordEntity);

    expect(result.isLeft(), true);
    expect(result.fold((failure) => failure, (success) => success), isA<SaveFavoriteWordFailure>());
  });
}
