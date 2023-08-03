import 'package:english_dictionary/core/feature/favorites/cubit/favorites_cubit.dart';
import 'package:english_dictionary/core/feature/history/cubit/history_cubit.dart';
import 'package:english_dictionary/core/feature/history/domain/entities/history_word_entity.dart';
import 'package:english_dictionary/core/feature/user_details/cubit/user_details_cubit.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/entities/word_signification_entity.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/usecases/get_word_signification/get_word_signification_usecase_interface.dart';
import 'package:english_dictionary/core/feature/words/cubit/words_cubit.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
import 'package:english_dictionary/core/services/tts/tts_service_interface.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'word_signification_state.dart';

class WordSignificationCubit extends Cubit<WordSignificationState> {
  final IGetWordSignificationUsecase _getWordSignificationUsecase;
  final ITtsService _iTtsService;

  WordSignificationCubit(
    this._getWordSignificationUsecase,
    this._iTtsService,
  ) : super(const WordSignificationState());

  final userDetailsCubit = GetIt.I.get<UserDetailsCubit>();

  final wordsCubit = GetIt.I.get<WordsCubit>();
  final favoritesCubit = GetIt.I.get<FavoritesCubit>();
  final historyCubit = GetIt.I.get<HistoryCubit>();

  Future<void> init(WordEntity word) async {
    emit(state.copyWith(loading: true, word: word));
    await _getWordSignification(word);
    emit(state.copyWith(loading: false));
  }

  Future<void> _getWordSignification(WordEntity word, {bool ignoreLoading = false}) async {
    emit(state.copyWith(word: word, loading: !ignoreLoading));
    final (failure, result) = await _getWordSignificationUsecase.call(word.word);

    if (!result.isEmpty) {
      userDetailsCubit.addWordToCountOfNewWords(word);
      historyCubit.saveHistoryWord(_toHistoryWordEntity(word));
      emit(state.copyWith(wordSignification: result, loading: false));
      return;
    }

    emit(state.copyWith(errorMessage: failure!.message, loading: false));
  }

  Future<bool> startSpeak(String text) async {
    return await _iTtsService.speak(text);
  }

  Future<bool> stopSpeak() async {
    return await _iTtsService.stop();
  }

  Future<bool> pauseSpeak() async {
    return await _iTtsService.pause();
  }

  Future<void> nextWord() async {
    final nextWord = await wordsCubit.nextWord(state.word);
    await _getWordSignification(nextWord);
  }

  Future<void> searchWord(String word) async {
    final wordEntity = WordEntity(word: word);
    await _getWordSignification(wordEntity, ignoreLoading: true);
  }

  HistoryWordEntity _toHistoryWordEntity(WordEntity word) {
    return HistoryWordEntity(
      id: word.id,
      word: word.word,
    );
  }

  void dispose() {
    emit(const WordSignificationState());
  }
}
