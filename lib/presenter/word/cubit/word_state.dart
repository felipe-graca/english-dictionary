part of 'word_cubit.dart';

class WordState extends Equatable {
  final WordSignificationEntity wordSignificationEntity;
  final WordEntity word;
  final ExampleEntity example;
  final bool isLoading;
  final bool wasSubmitted;
  final dynamic failure;
  const WordState({
    this.wordSignificationEntity = const WordSignificationEntity(),
    this.example = const ExampleEntity(),
    this.isLoading = false,
    this.wasSubmitted = false,
    this.word = const WordEntity(),
    this.failure,
  });

  @override
  List<Object?> get props => [
        wordSignificationEntity,
        example,
        isLoading,
        failure,
        wasSubmitted,
        word,
      ];

  WordState copyWith({
    WordSignificationEntity? wordSignificationEntity,
    ExampleEntity? example,
    bool? isLoading,
    dynamic Function()? failure,
    bool? wasSubmitted,
    WordEntity? wordEntity,
  }) {
    return WordState(
      wordSignificationEntity: wordSignificationEntity ?? this.wordSignificationEntity,
      example: example ?? this.example,
      isLoading: isLoading ?? this.isLoading,
      failure: failure != null ? failure() : this.failure,
      wasSubmitted: wasSubmitted ?? this.wasSubmitted,
      word: wordEntity ?? word,
    );
  }
}
