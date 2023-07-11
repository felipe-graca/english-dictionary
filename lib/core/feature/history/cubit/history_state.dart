part of 'history_cubit.dart';

enum AuthStatus { authenticated, unauthenticated }

class HistoryState extends Equatable {
  final List<HistoryWordEntity> words;
  final bool wasSubmitted;
  final String errorMessage;

  const HistoryState({
    this.words = const <HistoryWordEntity>[],
    this.wasSubmitted = false,
    this.errorMessage = '',
  });

  @override
  List<Object?> get props => [
        words,
        wasSubmitted,
        errorMessage,
      ];

  HistoryState copyWith({
    final List<HistoryWordEntity>? words,
    final bool? wasSubmitted,
    final String? errorMessage,
  }) {
    return HistoryState(
      words: words ?? this.words,
      wasSubmitted: wasSubmitted ?? this.wasSubmitted,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
