part of 'word_signification_cubit.dart';

enum AuthStatus { authenticated, unauthenticated }

class WordSignificationState extends Equatable {
  final String word;
  final dynamic failure;
  final WordSignificationEntity wordSignification;
  final ExampleEntity? example;
  final WordEntity wordEntity;
  const WordSignificationState({
    this.word = '',
    this.wordSignification = const WordSignificationEntity(),
    this.failure,
    this.example,
    this.wordEntity = const WordEntity(),
  });

  @override
  List<Object?> get props => [
        word,
        wordSignification,
        failure,
        example,
        wordEntity,
      ];

  WordSignificationState copyWith({
    final String? word,
    final WordSignificationEntity? wordSignification,
    final dynamic Function()? failure,
    final ExampleEntity? example,
    final WordEntity? wordEntity,
  }) {
    return WordSignificationState(
      word: word ?? this.word,
      wordSignification: wordSignification ?? this.wordSignification,
      failure: failure != null ? failure() : this.failure,
      example: example ?? this.example,
      wordEntity: wordEntity ?? this.wordEntity,
    );
  }
}
