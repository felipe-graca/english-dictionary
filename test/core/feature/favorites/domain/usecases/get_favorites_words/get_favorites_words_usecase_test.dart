import 'package:english_dictionary/core/feature/favorites/core/errors/favorites_failure.dart';
import 'package:english_dictionary/core/feature/favorites/data/repositories/get_favorites_words/get_favorites_words_repository.dart';
import 'package:english_dictionary/core/feature/favorites/domain/entities/favorite_word_entity.dart';
import 'package:english_dictionary/core/feature/favorites/domain/usecases/get_favorites_words/get_favorites_words_usecase.dart';
import 'package:english_dictionary/core/feature/favorites/domain/usecases/get_favorites_words/get_favorites_words_usecase_interface.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_favorites_words_usecase_test.mocks.dart';

@GenerateMocks([GetFavoritesWordsRepository])
main() {
  final repository = MockGetFavoritesWordsRepository();
  final IGetFavoritesWordsUsecase usecase = GetFavoritesWordsUsecase(repository);

  final faker = Faker();

  final wordEntity = FavoriteWordEntity(
    id: faker.guid.guid(),
    word: faker.lorem.word(),
  );

  test(
    'Should return a list of words entity',
    () async {
      when(repository.getFavoritesWords()).thenAnswer((_) async => (null, <FavoriteWordEntity>[wordEntity]));

      final (failure, result) = await usecase.call(noParams);

      expect(result, <FavoriteWordEntity>[wordEntity]);
      expect(failure, null);

      verify(repository.getFavoritesWords()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );

  test(
    'Should return a GetFavoritesWordsFailure when not found words',
    () async {
      when(repository.getFavoritesWords()).thenAnswer((_) async => (GetFavoritesWordsFailure(), <FavoriteWordEntity>[]));

      final (failure, result) = await usecase.call(noParams);

      expect(result, <FavoriteWordEntity>[]);
      expect(failure, isA<GetFavoritesWordsFailure>());

      verify(repository.getFavoritesWords()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
