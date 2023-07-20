import 'package:english_dictionary/core/feature/favorites/cubit/favorites_cubit.dart';
import 'package:english_dictionary/core/feature/user_details/cubit/user_details_cubit.dart';
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
  final userDetailsCubit = GetIt.I.get<UserDetailsCubit>();

  Future<void> init(WordEntity word) async {
    emit(state.copyWith(loading: true, word: word));
    await getWordSignificationAndExample(word);
    emit(state.copyWith(loading: false));
  }

  Future<void> getWordSignification(WordEntity word) async {
    emit(state.copyWith(word: word));
    final (failure, result) = await _getWordSignificationUsecase.call(word.word);

    if (!result.isEmpty) {
      emit(state.copyWith(wordSignification: result));
      return;
    }

    emit(state.copyWith(errorMessage: failure!.message));
  }

  Future<void> getWordSignificationExample(WordEntity word) async {
    final (failure, example) = await _getWordSignificationExampleUsecase.call(word.word);

    if (!example.isEmpty) {
      emit(state.copyWith(example: example));
      return;
    }
    emit(state.copyWith(errorMessage: failure!.message));
  }

  Future<void> getWordSignificationAndExample(WordEntity word, {bool ignoreLoading = false}) async {
    if (!ignoreLoading) {
      emit(state.copyWith(loading: true));
    }
    await getWordSignification(word);
    await getWordSignificationExample(word);

    await userDetailsCubit.addWordToCountOfNewWords(word);

    if (!ignoreLoading) {
      emit(state.copyWith(loading: false));
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

  Future<void> nextWord() async {
    emit(state.copyWith(loadingStatus: LoadingStatus.isLoading));
    final nextWord = await wordsCubit.nextWord(state.word);
    await getWordSignificationAndExample(nextWord, ignoreLoading: true);
    emit(state.copyWith(loadingStatus: LoadingStatus.isNotLoading));
  }

  Future<void> searchWord(String word) async {
    emit(state.copyWith(loadingStatus: LoadingStatus.isLoading));
    final wordEntity = WordEntity(word: word);
    await getWordSignificationAndExample(wordEntity, ignoreLoading: true);
    emit(state.copyWith(loadingStatus: LoadingStatus.isNotLoading));
  }
}
