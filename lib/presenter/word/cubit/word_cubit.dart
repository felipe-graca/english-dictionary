import 'package:english_dictionary/core/feature/word_signification/cubit/word_signification_cubit.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/entities/exemple_entity.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
import 'package:english_dictionary/core/services/tts/tts_service_interface.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../core/feature/word_signification/domain/entities/word_signification_entity.dart';

part 'word_state.dart';

class WordCubit extends Cubit<WordState> {
  final ITtsService _iTtsService;
  WordCubit(this._iTtsService) : super(const WordState());

  final wordSignificationCubit = GetIt.I.get<WordSignificationCubit>();

  Future<void> getWordSignification(WordEntity word) async {
    emit(state.copyWith(isLoading: true, failure: () => null));

    await wordSignificationCubit.getWordSignificationAndExample(word).then(
          (value) => emit(
            state.copyWith(
              wordSignificationEntity: wordSignificationCubit.state.wordSignification,
              example: wordSignificationCubit.state.example,
              failure: () => wordSignificationCubit.state.failure,
            ),
          ),
        );
    emit(state.copyWith(isLoading: false));
  }

  void toggleFavorite() {
    emit(state.copyWith(isFavorite: !state.isFavorite));
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
    if (state.wasSubmitted) return;
    emit(state.copyWith(wasSubmitted: true, failure: () => null));
    try {
      await wordSignificationCubit.nextWord();
    } catch (e) {
      emit(state.copyWith(failure: () => e, wasSubmitted: false));
    }

    emit(state.copyWith(
      wordSignificationEntity: wordSignificationCubit.state.wordSignification,
      example: wordSignificationCubit.state.example,
      failure: () => wordSignificationCubit.state.failure,
      wasSubmitted: false,
    ));
  }

  bool get hasFailure => state.failure != null;
}
