part of 'word_cubit.dart';

class WordState extends Equatable {
  final WordSignificationEntity wordSignificationEntity;
  final ExampleEntity example;
  final bool isFavorite;
  final bool isLoading;
  final bool wasSubmitted;
  final dynamic failure;
  const WordState({
    this.wordSignificationEntity = const WordSignificationEntity(),
    this.example = const ExampleEntity(),
    this.isFavorite = false,
    this.isLoading = false,
    this.wasSubmitted = false,
    this.failure,
  });

  @override
  List<Object?> get props => [
        wordSignificationEntity,
        example,
        isFavorite,
        isLoading,
        failure,
        wasSubmitted,
      ];

  WordState copyWith({
    WordSignificationEntity? wordSignificationEntity,
    ExampleEntity? example,
    bool? isFavorite,
    bool? isLoading,
    dynamic Function()? failure,
    bool? wasSubmitted,
  }) {
    return WordState(
      wordSignificationEntity: wordSignificationEntity ?? this.wordSignificationEntity,
      example: example ?? this.example,
      isFavorite: isFavorite ?? this.isFavorite,
      isLoading: isLoading ?? this.isLoading,
      failure: failure != null ? failure() : this.failure,
      wasSubmitted: wasSubmitted ?? this.wasSubmitted,
    );
  }
}
