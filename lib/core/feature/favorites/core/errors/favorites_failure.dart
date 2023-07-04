import 'package:english_dictionary/core/errors/failure.dart';

class FavoritesFailure extends Failure {
  FavoritesFailure({String message = 'Something went wrong at Words'}) : super(message: message);
}

class SaveFavoriteWordFailure extends FavoritesFailure {
  SaveFavoriteWordFailure({String message = 'Something went wrong at Save Favorite Word'}) : super(message: message);
}

class GetFavoritesWordsFailure extends FavoritesFailure {
  GetFavoritesWordsFailure({String message = 'Something went wrong at Get Favorites Words'}) : super(message: message);
}

class RemoveFavoriteWordFailure extends FavoritesFailure {
  RemoveFavoriteWordFailure({String message = 'Something went wrong at Remove Favorite Word'}) : super(message: message);
}
