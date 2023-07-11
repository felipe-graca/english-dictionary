import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/favorites/core/errors/favorites_failure.dart';
import 'package:english_dictionary/core/feature/favorites/cubit/favorites_cubit.dart';
import 'package:english_dictionary/core/feature/favorites/domain/usecases/get_favorites_words/get_favorites_words_usecase.dart';
import 'package:english_dictionary/core/feature/favorites/domain/usecases/remove_favorite_word/remove_favorite_word_usecase.dart';
import 'package:english_dictionary/core/feature/favorites/domain/usecases/save_favorite_word/save_favorite_word_usecase.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'favorites_cubit_test.mocks.dart';

@GenerateMocks([
  GetFavoritesWordsUsecase,
  RemoveFavoriteWordUsecase,
  SaveFavoriteWordUsecase,
])
main() {
  final mockGetFavoritesWordsUsecase = MockGetFavoritesWordsUsecase();
  final mockRemoveFavoriteWordUsecase = MockRemoveFavoriteWordUsecase();
  final mockSaveFavoriteWordUsecase = MockSaveFavoriteWordUsecase();

  final favoritesCubit = FavoritesCubit(
    mockGetFavoritesWordsUsecase,
    mockRemoveFavoriteWordUsecase,
    mockSaveFavoriteWordUsecase,
  );

  group('getFavoritesWords()', () {
    test('should get favorites words', () async {
      when(mockGetFavoritesWordsUsecase.call(noParams)).thenAnswer((_) async => const Right([]));

      favoritesCubit.getFavoritesWords();

      await untilCalled(mockGetFavoritesWordsUsecase.call(noParams));
      verify(mockGetFavoritesWordsUsecase.call(noParams));

      expect(favoritesCubit.state.words, []);
    });

    test('should get favorites words failure', () async {
      when(mockGetFavoritesWordsUsecase.call(noParams)).thenAnswer((_) async => Left(GetFavoritesWordsFailure()));

      favoritesCubit.getFavoritesWords();

      await untilCalled(mockGetFavoritesWordsUsecase.call(noParams));
      verify(mockGetFavoritesWordsUsecase.call(noParams));

      expect(favoritesCubit.state.errorMessage, GetFavoritesWordsFailure().toString());
    });
  });
}
