import 'package:english_dictionary/core/feature/history/domain/usecases/get_history_words/get_history_words_usecase_interface.dart';
import 'package:english_dictionary/core/feature/history/domain/usecases/clear_history_word/clear_history_word_usecase_interface.dart';
import 'package:english_dictionary/core/feature/history/domain/usecases/save_history_word/save_history_word_usecase_interface.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final IGetHistoryWordsUsecase _getFavoritesWordsUsecase;
  final IClearHistoryWordsUsecase _removeFavoriteWordUsecase;
  final ISaveHistoryWordsUsecase _saveFavoriteWordUsecase;
  HistoryCubit(
    this._getFavoritesWordsUsecase,
    this._removeFavoriteWordUsecase,
    this._saveFavoriteWordUsecase,
  ) : super(const HistoryState());

  Future<void> getHistoryWords() async {
    emit(const HistoryState());
    try {
      emit(state.copyWith(wasSubmitted: true));
      final words = await _getFavoritesWordsUsecase.call(noParams);
      words.fold(
        (failure) => throw failure,
        (success) => emit(state.copyWith(words: success, wasSubmitted: false)),
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), wasSubmitted: false));
    }
  }

  Future<bool> clearHistoryWords() async {
    try {
      emit(state.copyWith(wasSubmitted: true));
      final result = await _removeFavoriteWordUsecase.call(noParams);
      result.fold(
        (failure) => throw failure,
        (success) => emit(state.copyWith(words: [], wasSubmitted: false)),
      );
      return true;
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), wasSubmitted: false));
      return false;
    }
  }

  Future<bool> saveHistoryWord(WordEntity wordEntity) async {
    try {
      emit(state.copyWith(wasSubmitted: true));
      final result = await _saveFavoriteWordUsecase.call(wordEntity);
      result.fold(
        (failure) => throw failure,
        (success) => {
          if (!state.words.contains(wordEntity)) emit(state.copyWith(words: [...state.words, wordEntity], wasSubmitted: false))
        },
      );
      return true;
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), wasSubmitted: false));
      return false;
    }
  }

  bool isFavorite(WordEntity word) => state.words.contains(word);

  bool get isLoading => state.wasSubmitted;
}
