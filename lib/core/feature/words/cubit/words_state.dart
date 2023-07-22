part of 'words_cubit.dart';

enum AuthStatus { authenticated, unauthenticated }

class WordsState extends Equatable {
  final List<WordEntity> words;
  final String errorMessage;
  final bool loading;
  final bool aiLoading;
  const WordsState({
    this.words = const <WordEntity>[],
    this.errorMessage = '',
    this.loading = false,
    this.aiLoading = false,
  });

  @override
  List<Object?> get props => [
        words,
        errorMessage,
        loading,
        aiLoading,
      ];

  WordsState copyWith({
    final List<WordEntity>? words,
    final String? errorMessage,
    final bool? loading,
    final bool? aiLoading,
  }) {
    return WordsState(
      words: words ?? this.words,
      errorMessage: errorMessage ?? this.errorMessage,
      loading: loading ?? this.loading,
      aiLoading: aiLoading ?? this.aiLoading,
    );
  }
}
