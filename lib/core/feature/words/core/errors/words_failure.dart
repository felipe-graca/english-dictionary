import 'package:english_dictionary/core/errors/failure.dart';

class WordsFailure extends Failure {
  WordsFailure({String message = 'Something went wrong at Words'}) : super(message: message);
}

class GetWordsFailure extends Failure {
  GetWordsFailure({String message = 'Something went wrong at Get Words'}) : super(message: message);
}

class SaveFavoriteWordFailure extends Failure {
  SaveFavoriteWordFailure({String message = 'Something went wrong at Save Favorite Word'}) : super(message: message);
}

class GetFavoritesWordsFailure extends Failure {
  GetFavoritesWordsFailure({String message = 'Something went wrong at Get Favorites Words'}) : super(message: message);
}

class RemoveFavoriteWordFailure extends Failure {
  RemoveFavoriteWordFailure({String message = 'Something went wrong at Remove Favorite Word'}) : super(message: message);
}
