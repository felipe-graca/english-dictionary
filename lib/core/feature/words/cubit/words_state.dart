part of 'words_cubit.dart';

enum AuthStatus { authenticated, unauthenticated }

class WordsState extends Equatable {
  final List<WordEntity> words;
  final WordsFailure? failure;

  const WordsState({
    this.words = const <WordEntity>[],
    this.failure,
  });

  @override
  List<Object?> get props => [
        words,
        failure,
      ];

  WordsState copyWith({
    final List<WordEntity>? words,
    final WordsFailure? failure,
  }) {
    return WordsState(
      words: words ?? this.words,
      failure: failure ?? this.failure,
    );
  }
}
