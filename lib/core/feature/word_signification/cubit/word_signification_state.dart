part of 'word_signification_cubit.dart';

class WordSignificationState extends Equatable {
  final WordSignificationEntity wordSignification;
  final ExampleEntity example;
  final WordEntity word;
  final bool loading;
  final String errorMessage;

  const WordSignificationState({
    this.wordSignification = const WordSignificationEntity(),
    this.example = const ExampleEntity(),
    this.word = const WordEntity(),
    this.loading = false,
    this.errorMessage = '',
  });

  @override
  List<Object?> get props => [
        wordSignification,
        example,
        word,
        loading,
        errorMessage,
      ];

  WordSignificationState copyWith({
    final WordSignificationEntity? wordSignification,
    final ExampleEntity? example,
    final WordEntity? word,
    final bool? loading,
    final String? errorMessage,
  }) {
    return WordSignificationState(
      wordSignification: wordSignification ?? this.wordSignification,
      example: example ?? this.example,
      word: word ?? this.word,
      loading: loading ?? this.loading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
