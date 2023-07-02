part of 'word_signification_cubit.dart';

enum AuthStatus { authenticated, unauthenticated }

class WordSignificationState extends Equatable {
  final String word;
  final GetWordSignificationFailure? failure;
  final WordSignificationEntity wordSignification;
  const WordSignificationState({
    this.word = '',
    this.wordSignification = const WordSignificationEntity(),
    this.failure,
  });

  @override
  List<Object?> get props => [
        word,
        wordSignification,
        failure,
      ];

  WordSignificationState copyWith({
    final String? word,
    final WordSignificationEntity? wordSignification,
    final GetWordSignificationFailure? failure,
  }) {
    return WordSignificationState(
      word: word ?? this.word,
      wordSignification: wordSignification ?? this.wordSignification,
      failure: failure ?? this.failure,
    );
  }
}
