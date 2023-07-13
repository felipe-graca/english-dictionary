part of 'word_signification_cubit.dart';

enum LoadingStatus { isLoading, isNotLoading }

class WordSignificationState extends Equatable {
  final WordSignificationEntity wordSignification;
  final ExampleEntity example;
  final WordEntity word;
  final bool loading;
  final String errorMessage;
  final LoadingStatus loadingStatus;
  const WordSignificationState({
    this.wordSignification = const WordSignificationEntity(),
    this.example = const ExampleEntity(),
    this.word = const WordEntity(),
    this.loading = false,
    this.errorMessage = '',
    this.loadingStatus = LoadingStatus.isNotLoading,
  });

  @override
  List<Object?> get props => [
        wordSignification,
        example,
        word,
        loading,
        errorMessage,
        loadingStatus,
      ];

  WordSignificationState copyWith({
    final WordSignificationEntity? wordSignification,
    final ExampleEntity? example,
    final WordEntity? word,
    final bool? loading,
    final String? errorMessage,
    final LoadingStatus? loadingStatus,
  }) {
    return WordSignificationState(
      wordSignification: wordSignification ?? this.wordSignification,
      example: example ?? this.example,
      word: word ?? this.word,
      loading: loading ?? this.loading,
      errorMessage: errorMessage ?? this.errorMessage,
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }
}
