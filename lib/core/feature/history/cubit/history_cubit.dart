import 'package:english_dictionary/core/feature/history/domain/entities/history_word_entity.dart';
import 'package:english_dictionary/core/feature/history/domain/usecases/get_history_words/get_history_words_usecase_interface.dart';
import 'package:english_dictionary/core/feature/history/domain/usecases/clear_history_word/clear_history_word_usecase_interface.dart';
import 'package:english_dictionary/core/feature/history/domain/usecases/save_history_word/save_history_word_usecase_interface.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final IGetHistoryWordsUsecase _getFavoritesWordsUsecase;
  final IClearHistoryWordsUsecase _clearHistoryWordsUsecase;
  final ISaveHistoryWordUsecase _saveFavoriteWordUsecase;
  HistoryCubit(
    this._getFavoritesWordsUsecase,
    this._clearHistoryWordsUsecase,
    this._saveFavoriteWordUsecase,
  ) : super(const HistoryState());

  Future<void> getHistoryWords() async {
    emit(state.copyWith(loading: true));

    final (failure, words) = await _getFavoritesWordsUsecase.call(noParams);
    if (words.isNotEmpty || failure == null) {
      emit(state.copyWith(words: words, loading: false));
      return;
    }
    emit(state.copyWith(errorMessage: failure.message, loading: false));
  }

  Future<bool> clearHistoryWords() async {
    emit(state.copyWith(loading: true));
    final (failure, result) = await _clearHistoryWordsUsecase.call(noParams);

    if (result) {
      emit(state.copyWith(words: [], loading: false));
      return true;
    }
    emit(state.copyWith(errorMessage: failure!.message, loading: false));
    return false;
  }

  Future<bool> saveHistoryWord(HistoryWordEntity wordEntity) async {
    emit(state.copyWith(loading: true));
    final (failure, result) = await _saveFavoriteWordUsecase.call(wordEntity);

    if (result) {
      if (state.words.contains(wordEntity)) {
        emit(state.copyWith(words: state.words.where((element) => element != wordEntity).toList()));
      }
      emit(state.copyWith(words: [wordEntity, ...state.words], loading: false));
      return true;
    }
    emit(state.copyWith(errorMessage: failure!.message, loading: false));
    return false;
  }

  void dispose() {
    emit(state.copyWith(loading: false, errorMessage: ''));
  }

  bool get isLoading => state.loading;
}
