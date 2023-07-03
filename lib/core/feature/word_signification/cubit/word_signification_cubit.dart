import 'package:english_dictionary/core/feature/word_signification/domain/entities/exemple_entity.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/entities/word_signification_entity.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/usecases/get_word_signification/get_word_signification_usecase_interface.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/usecases/get_word_signification_exemple/get_word_signification_exemple_usecase_interface.dart';
import 'package:english_dictionary/core/feature/words/cubit/words_cubit.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'word_signification_state.dart';

class WordSignificationCubit extends Cubit<WordSignificationState> {
  final IGetWordSignificationUsecase _getWordSignificationUsecase;
  final IGetWordSignificationExampleUsecase _getWordSignificationExampleUsecase;

  WordSignificationCubit(this._getWordSignificationUsecase, this._getWordSignificationExampleUsecase) : super(const WordSignificationState());

  final wordsCubit = GetIt.I.get<WordsCubit>();

  Future<void> getWordSignification(String word) async {
    final result = await _getWordSignificationUsecase.call(word);
    result.fold(
      (failure) => emit(state.copyWith(failure: () => failure)),
      (success) => emit(state.copyWith(wordSignification: success, failure: () => null)),
    );
  }

  Future<void> getWordSignificationExample(String word) async {
    final result = await _getWordSignificationExampleUsecase.call(word);
    result.fold(
      (failure) => emit(state.copyWith(failure: () => failure)),
      (success) => emit(state.copyWith(example: success, failure: () => null)),
    );
  }

  Future<void> getWordSignificationAndExample(WordEntity word) async {
    await getWordSignification(word.word);
    await getWordSignificationExample(word.word);

    emit(state.copyWith(wordEntity: word));
  }

  Future<void> nextWord() async {
    final nextWord = await wordsCubit.nextWord(state.wordEntity);
    await getWordSignificationAndExample(nextWord);
  }

  bool get isFailure => state.failure != null;
}
