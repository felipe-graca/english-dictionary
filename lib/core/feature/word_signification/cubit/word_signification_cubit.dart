import 'package:english_dictionary/core/feature/word_signification/core/errors/word_signification_failure.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/entities/word_signification_entity.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/usecases/get_word_signification/get_word_signification_usecase_interface.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'word_signification_state.dart';

class WordSignificationCubit extends Cubit<WordSignificationState> {
  final IGetWordSignificationUsecase _getWordSignificationUsecase;

  WordSignificationCubit(this._getWordSignificationUsecase) : super(const WordSignificationState());

  Future<void> getWordSignification(String word) async {
    final result = await _getWordSignificationUsecase(word);
    result.fold(
      (failure) => emit(state.copyWith(failure: failure)),
      (success) => emit(state.copyWith(wordSignification: success)),
    );
  }
}
