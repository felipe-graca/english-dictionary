part of 'history_cubit.dart';

enum AuthStatus { authenticated, unauthenticated }

class HistoryState extends Equatable {
  final List<HistoryWordEntity> words;
  final bool loading;
  final String errorMessage;

  const HistoryState({
    this.words = const <HistoryWordEntity>[],
    this.loading = false,
    this.errorMessage = '',
  });

  @override
  List<Object?> get props => [
        words,
        loading,
        errorMessage,
      ];

  HistoryState copyWith({
    final List<HistoryWordEntity>? words,
    final bool? loading,
    final String? errorMessage,
  }) {
    return HistoryState(
      words: words ?? this.words,
      loading: loading ?? this.loading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
