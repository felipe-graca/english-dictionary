import 'package:english_dictionary/core/feature/favorites/domain/entities/favorite_word_entity.dart';
import 'package:english_dictionary/core/feature/favorites/domain/usecases/get_favorites_words/get_favorites_words_usecase_interface.dart';
import 'package:english_dictionary/core/feature/favorites/domain/usecases/remove_favorite_word/remove_favorite_word_usecase_interface.dart';
import 'package:english_dictionary/core/feature/favorites/domain/usecases/save_favorite_word/save_favorite_word_usecase_interface.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final IGetFavoritesWordsUsecase _getFavoritesWordsUsecase;
  final IRemoveFavoriteWordUsecase _removeFavoriteWordUsecase;
  final ISaveFavoriteWordUsecase _saveFavoriteWordUsecase;
  FavoritesCubit(
    this._getFavoritesWordsUsecase,
    this._removeFavoriteWordUsecase,
    this._saveFavoriteWordUsecase,
  ) : super(const FavoritesState());

  Future<void> getFavoritesWords() async {
    emit(const FavoritesState());
    try {
      emit(state.copyWith(loading: true));
      final words = await _getFavoritesWordsUsecase.call(noParams);
      words.fold(
        (failure) => throw failure,
        (success) => {
          emit(
            state.copyWith(
              words: success,
              loading: false,
            ),
          ),
        },
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), loading: false));
    }
  }

  Future<bool> removeFavoriteWord(WordEntity wordEntity) async {
    final favoriteWordEntity = FavoriteWordEntity(id: wordEntity.id, word: wordEntity.word);
    try {
      emit(state.copyWith(loading: true));
      final result = await _removeFavoriteWordUsecase.call(favoriteWordEntity);

      result.fold(
        (failure) => throw failure,
        (success) => {
          emit(
            state.copyWith(
              words: state.words.where((element) => element != wordEntity).toList(),
              loading: false,
            ),
          ),
        },
      );
      return true;
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), loading: false));
      return false;
    }
  }

  Future<bool> saveFavoriteWord(WordEntity wordEntity) async {
    final favoriteWordEntity = FavoriteWordEntity(id: wordEntity.id, word: wordEntity.word);

    try {
      emit(state.copyWith(loading: true));
      final result = await _saveFavoriteWordUsecase.call(favoriteWordEntity);
      result.fold(
        (failure) => throw failure,
        (success) => {
          if (!state.words.contains(favoriteWordEntity))
            {
              emit(
                state.copyWith(
                  words: [...state.words, favoriteWordEntity],
                  loading: false,
                ),
              ),
            }
        },
      );
      return true;
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), loading: false));
      return false;
    }
  }

  bool isFavorite(FavoriteWordEntity word) => state.words.contains(word);

  bool get isLoading => state.loading;
}
