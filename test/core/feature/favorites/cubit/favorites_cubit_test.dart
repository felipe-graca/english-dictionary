import 'package:english_dictionary/core/feature/favorites/core/errors/favorites_failure.dart';
import 'package:english_dictionary/core/feature/favorites/cubit/favorites_cubit.dart';
import 'package:english_dictionary/core/feature/favorites/domain/entities/favorite_word_entity.dart';
import 'package:english_dictionary/core/feature/favorites/domain/usecases/get_favorites_words/get_favorites_words_usecase.dart';
import 'package:english_dictionary/core/feature/favorites/domain/usecases/remove_favorite_word/remove_favorite_word_usecase.dart';
import 'package:english_dictionary/core/feature/favorites/domain/usecases/save_favorite_word/save_favorite_word_usecase.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
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

  const favoriteWord = FavoriteWordEntity(id: '1', word: 'word');

  group('getFavoritesWords()', () {
    test('should get favorites words', () async {
      when(mockGetFavoritesWordsUsecase.call(noParams)).thenAnswer((_) async => (null, <FavoriteWordEntity>[favoriteWord]));

      favoritesCubit.getFavoritesWords();

      await untilCalled(mockGetFavoritesWordsUsecase.call(noParams));
      verify(mockGetFavoritesWordsUsecase.call(noParams)).called(1);

      expect(favoritesCubit.state.words, <FavoriteWordEntity>[favoriteWord]);
    });

    test('should get favorites words failure', () async {
      when(mockGetFavoritesWordsUsecase.call(noParams)).thenAnswer((_) async => (GetFavoritesWordsFailure(), <FavoriteWordEntity>[]));

      favoritesCubit.getFavoritesWords();

      await untilCalled(mockGetFavoritesWordsUsecase.call(noParams));
      verify(mockGetFavoritesWordsUsecase.call(noParams)).called(1);

      expect(favoritesCubit.state.errorMessage, GetFavoritesWordsFailure().message);
    });
  });

  group('removeFavoriteWord()', () {
    test('should remove favorite word', () async {
      when(mockRemoveFavoriteWordUsecase.call(favoriteWord)).thenAnswer((_) async => (null, true));

      final result = await favoritesCubit.removeFavoriteWord(const WordEntity(id: '1', word: 'word'));

      await untilCalled(mockRemoveFavoriteWordUsecase.call(favoriteWord));
      verify(mockRemoveFavoriteWordUsecase.call(favoriteWord)).called(1);

      expect(favoritesCubit.state.words, <FavoriteWordEntity>[]);
      expect(result, true);
    });

    test('should remove favorite word failure', () async {
      when(mockRemoveFavoriteWordUsecase.call(favoriteWord)).thenAnswer((_) async => (RemoveFavoriteWordFailure(), false));

      final result = await favoritesCubit.removeFavoriteWord(const WordEntity(id: '1', word: 'word'));

      await untilCalled(mockRemoveFavoriteWordUsecase.call(favoriteWord));
      verify(mockRemoveFavoriteWordUsecase.call(favoriteWord)).called(1);

      expect(favoritesCubit.state.errorMessage, RemoveFavoriteWordFailure().message);
      expect(result, false);
    });
  });

  group(
    'saveFavoriteWord()',
    () {
      test(
        'should save favorite word',
        () async {
          when(mockSaveFavoriteWordUsecase.call(favoriteWord)).thenAnswer((_) async => (null, true));

          final result = await favoritesCubit.saveFavoriteWord(const WordEntity(id: '1', word: 'word'));

          await untilCalled(mockSaveFavoriteWordUsecase.call(favoriteWord));
          verify(mockSaveFavoriteWordUsecase.call(favoriteWord)).called(1);

          expect(favoritesCubit.state.words, <FavoriteWordEntity>[favoriteWord]);
          expect(result, true);
        },
      );

      test(
        'should save favorite word failure',
        () async {
          when(mockSaveFavoriteWordUsecase.call(favoriteWord)).thenAnswer((_) async => (SaveFavoriteWordFailure(), false));

          final result = await favoritesCubit.saveFavoriteWord(const WordEntity(id: '1', word: 'word'));

          await untilCalled(mockSaveFavoriteWordUsecase.call(favoriteWord));
          verify(mockSaveFavoriteWordUsecase.call(favoriteWord)).called(1);

          expect(favoritesCubit.state.errorMessage, SaveFavoriteWordFailure().message);
          expect(result, false);
        },
      );
    },
  );
}
