import 'package:english_dictionary/core/feature/words/cubit/words_cubit.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'dictionary_state.dart';

class DictionaryCubit extends Cubit<DictionaryState> {
  DictionaryCubit() : super(const DictionaryState());

  final wordsCubit = GetIt.I.get<WordsCubit>();

  Future<void> onInit() async {
    emit(state.copyWith(loading: true));
    await wordsCubit.getWords();
    emit(state.copyWith(words: wordsCubit.state.words, loading: false));
  }
}
