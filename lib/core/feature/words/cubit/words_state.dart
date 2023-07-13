part of 'words_cubit.dart';

enum AuthStatus { authenticated, unauthenticated }

class WordsState extends Equatable {
  final List<WordEntity> words;
  final String errorMessage;
  final bool loading;

  const WordsState({
    this.words = const <WordEntity>[],
    this.errorMessage = '',
    this.loading = false,
  });

  @override
  List<Object?> get props => [
        words,
        errorMessage,
        loading,
      ];

  WordsState copyWith({
    final List<WordEntity>? words,
    final String? errorMessage,
    final bool? loading,
  }) {
    return WordsState(
      words: words ?? this.words,
      errorMessage: errorMessage ?? this.errorMessage,
      loading: loading ?? this.loading,
    );
  }
}
