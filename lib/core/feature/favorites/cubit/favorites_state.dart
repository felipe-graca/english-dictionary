part of 'favorites_cubit.dart';

enum AuthStatus { authenticated, unauthenticated }

class FavoritesState extends Equatable {
  final List<FavoriteWordEntity> words;
  final bool wasSubmitted;
  final String errorMessage;

  const FavoritesState({
    this.words = const <FavoriteWordEntity>[],
    this.wasSubmitted = false,
    this.errorMessage = '',
  });

  @override
  List<Object?> get props => [
        words,
        wasSubmitted,
        errorMessage,
      ];

  FavoritesState copyWith({
    final List<FavoriteWordEntity>? words,
    final bool? wasSubmitted,
    final String? errorMessage,
  }) {
    return FavoritesState(
      words: words ?? this.words,
      wasSubmitted: wasSubmitted ?? this.wasSubmitted,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
