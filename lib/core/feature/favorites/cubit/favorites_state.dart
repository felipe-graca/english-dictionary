part of 'favorites_cubit.dart';

enum AuthStatus { authenticated, unauthenticated }

class FavoritesState extends Equatable {
  final List<FavoriteWordEntity> words;
  final bool loading;
  final String errorMessage;

  const FavoritesState({
    this.words = const <FavoriteWordEntity>[],
    this.loading = false,
    this.errorMessage = '',
  });

  @override
  List<Object?> get props => [
        words,
        loading,
        errorMessage,
      ];

  FavoritesState copyWith({
    final List<FavoriteWordEntity>? words,
    final bool? loading,
    final String? errorMessage,
  }) {
    return FavoritesState(
      words: words ?? this.words,
      loading: loading ?? this.loading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
