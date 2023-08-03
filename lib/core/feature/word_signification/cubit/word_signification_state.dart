part of 'word_signification_cubit.dart';

class WordSignificationState extends Equatable {
  final WordSignificationEntity wordSignification;

  final WordEntity word;
  final bool loading;
  final String errorMessage;

  const WordSignificationState({
    this.wordSignification = const WordSignificationEntity(),
    this.word = const WordEntity(),
    this.loading = false,
    this.errorMessage = '',
  });

  @override
  List<Object?> get props => [
        wordSignification,
        word,
        loading,
        errorMessage,
      ];

  WordSignificationState copyWith({
    final WordSignificationEntity? wordSignification,
    final WordEntity? word,
    final bool? loading,
    final String? errorMessage,
  }) {
    return WordSignificationState(
      wordSignification: wordSignification ?? this.wordSignification,
      word: word ?? this.word,
      loading: loading ?? this.loading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
