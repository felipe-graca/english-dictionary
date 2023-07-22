import 'package:english_dictionary/core/feature/words/domain/entities/gpt_request_entity.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
import 'package:english_dictionary/core/feature/words/domain/usecases/get_gpt_words/get_gpt_words_usecase_interface.dart';
import 'package:english_dictionary/core/feature/words/domain/usecases/get_words/get_words_usecase_interface.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'words_state.dart';

class WordsCubit extends Cubit<WordsState> {
  final IGetWordsUsecase _getWordsUsecase;
  final IGetGptWordsUsecase _getGptWordsUsecase;
  WordsCubit(
    this._getWordsUsecase,
    this._getGptWordsUsecase,
  ) : super(const WordsState());

  Future<void> getWords() async {
    emit(state.copyWith(loading: true));
    final (failure, words) = await _getWordsUsecase.call(noParams);

    if (words.isNotEmpty) {
      emit(state.copyWith(words: words, loading: false));
      return;
    }

    emit(state.copyWith(errorMessage: failure!.message, loading: false));
  }

  Future<WordEntity> nextWord(WordEntity actualWordEntity) async {
    final index = state.words.indexOf(actualWordEntity);
    if (index < state.words.length - 1) {
      return state.words[index + 1];
    } else {
      return state.words[0];
    }
  }

  Future<void> getAiWords(String relatedWord) async {
    emit(state.copyWith(aiLoading: true));
    final (failure, result) = await _getGptWordsUsecase.call(
      GptRequestEntity(messages: [GptRequestMessageEntity(content: _builAIString(relatedWord), role: 'user')]),
    );

    if (result.isNotEmpty) {
      emit(state.copyWith(words: result, aiLoading: false));
      return;
    }
    emit(state.copyWith(errorMessage: failure!.message, aiLoading: false));
  }

  String _builAIString(String text) {
    return "Generate existentes 30 words(Only one word) related with $text. you need return in only one line";
  }
}
