import 'package:english_dictionary/core/feature/history/cubit/history_cubit.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/words_request_entity.dart';
import 'package:english_dictionary/core/feature/words/domain/usecases/get_gpt_words/get_gpt_words_usecase_interface.dart';
import 'package:english_dictionary/core/feature/words/domain/usecases/get_words/get_words_usecase_interface.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'words_state.dart';

class WordsCubit extends Cubit<WordsState> {
  final IGetWordsUsecase _getWordsUsecase;
  final IGetGptWordsUsecase _getGptWordsUsecase;
  WordsCubit(
    this._getWordsUsecase,
    this._getGptWordsUsecase,
  ) : super(const WordsState());

  final historyCubit = GetIt.I.get<HistoryCubit>();

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

    final wordsRequest = WordsRequestEntity(messages: [WordsRequestMessageEntity(content: _builAIString(relatedWord), role: 'user')]);

    final (failure, result) = await _getGptWordsUsecase.call(wordsRequest);

    if (result.isNotEmpty) {
      emit(state.copyWith(words: _replaceExistentsIdBasedOnHistoryWords(result), aiLoading: false));
      return;
    }
    emit(state.copyWith(errorMessage: failure!.message, aiLoading: false));
  }

  String _builAIString(String text) {
    return "Generate existentes 30 words(Only one word) related with $text. you need return in only one line";
  }

  List<WordEntity> _replaceExistentsIdBasedOnHistoryWords(List<WordEntity> words) => List<WordEntity>.from(
        words.map((word) {
          final historyWord = historyCubit.state.words.where((element) => element.word == word.word).firstOrNull;
          return historyWord != null ? word.copyWith(id: historyWord.id) : word;
        }),
      );
}
