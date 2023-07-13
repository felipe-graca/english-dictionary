import 'package:english_dictionary/core/feature/favorites/cubit/favorites_cubit.dart';
import 'package:english_dictionary/core/feature/favorites/domain/entities/favorite_word_entity.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/entities/exemple_entity.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/entities/word_signification_entity.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/usecases/get_word_signification/get_word_signification_usecase_interface.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/usecases/get_word_signification_exemple/get_word_signification_exemple_usecase_interface.dart';
import 'package:english_dictionary/core/feature/words/cubit/words_cubit.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
import 'package:english_dictionary/core/services/tts/tts_service_interface.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'word_signification_state.dart';

class WordSignificationCubit extends Cubit<WordSignificationState> {
  final IGetWordSignificationUsecase _getWordSignificationUsecase;
  final IGetWordSignificationExampleUsecase _getWordSignificationExampleUsecase;
  final ITtsService _iTtsService;

  WordSignificationCubit(
    this._getWordSignificationUsecase,
    this._getWordSignificationExampleUsecase,
    this._iTtsService,
  ) : super(const WordSignificationState());

  final wordsCubit = GetIt.I.get<WordsCubit>();
  final favoritesCubit = GetIt.I.get<FavoritesCubit>();

  Future<void> init(WordEntity word) async {
    emit(state.copyWith(loading: true, word: word));
    await getWordSignificationAndExample(word);
    emit(state.copyWith(loading: false));
  }

  Future<void> getWordSignification(String word) async {
    final result = await _getWordSignificationUsecase.call(word);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (success) => emit(state.copyWith(wordSignification: success)),
    );
  }

  Future<void> getWordSignificationExample(String word) async {
    final result = await _getWordSignificationExampleUsecase.call(word);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (success) => emit(state.copyWith(example: success)),
    );
  }

  Future<void> getWordSignificationAndExample(WordEntity word, {bool ignoreLoading = false}) async {
    if (!ignoreLoading) {
      emit(state.copyWith(loading: true));
    }
    await getWordSignification(word.word);
    await getWordSignificationExample(word.word);

    if (!ignoreLoading) {
      emit(state.copyWith(word: word, loading: false));
    }
  }

  //tts
  Future<bool> startSpeak(String text) async {
    return await _iTtsService.speak(text);
  }

  Future<bool> stopSpeak() async {
    return await _iTtsService.stop();
  }

  Future<bool> pauseSpeak() async {
    return await _iTtsService.pause();
  }

  bool isFavorite(FavoriteWordEntity entity) => favoritesCubit.isFavorite(entity);

  bool get favoriteloading => favoritesCubit.state.loading;
  bool get favoriteErrorMessage => favoritesCubit.state.errorMessage != '';

  Future<void> nextWord() async {
    emit(state.copyWith(example: const ExampleEntity()));
    final nextWord = await wordsCubit.nextWord(state.word);
    await getWordSignificationAndExample(nextWord, ignoreLoading: true);
  }
}
