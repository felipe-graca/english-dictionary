import 'package:english_dictionary/core/feature/words/core/errors/words_failure.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
import 'package:english_dictionary/core/feature/words/domain/usecases/get_words/get_words_usecase_interface.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'words_state.dart';

class WordsCubit extends Cubit<WordsState> {
  final IGetWordsUsecase _getWordsUsecase;
  WordsCubit(this._getWordsUsecase) : super(const WordsState());

  Future<void> getWords() async {
    try {
      final words = await _getWordsUsecase.call(noParams);
      words.fold(
        (failure) => throw failure,
        (success) => {
          emit(
            state.copyWith(
              words: success,
            ),
          ),
        },
      );
    } on GetWordsFailure catch (e) {
      emit(state.copyWith(failure: WordsFailure(message: 'Error while getting words: ${e.message}')));
    }
  }

  Future<WordEntity> nextWord(WordEntity actualWordEntity) async {
    final index = state.words.indexOf(actualWordEntity);
    if (index < state.words.length - 1) {
      return state.words[index + 1];
    } else {
      return state.words[0];
    }
  }
}
