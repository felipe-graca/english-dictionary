part of 'words_cubit.dart';

enum AuthStatus { authenticated, unauthenticated }

class WordsState extends Equatable {
  final List<WordEntity> words;
  final String errorMessage;

  const WordsState({
    this.words = const <WordEntity>[],
    this.errorMessage = '',
  });

  @override
  List<Object?> get props => [
        words,
        errorMessage,
      ];

  WordsState copyWith({
    final List<WordEntity>? words,
    final String? errorMessage,
  }) {
    return WordsState(
      words: words ?? this.words,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
