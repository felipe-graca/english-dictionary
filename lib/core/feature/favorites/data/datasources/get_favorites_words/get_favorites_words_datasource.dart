import 'package:english_dictionary/core/errors/failure.dart';
import 'package:english_dictionary/core/feature/favorites/core/errors/favorites_failure.dart';
import 'package:english_dictionary/core/feature/favorites/data/datasources/get_favorites_words/get_favorites_words_datasource_interface.dart';
import 'package:english_dictionary/core/feature/favorites/data/models/favorites_word_model.dart';
import 'package:english_dictionary/core/services/firebase/firebase_service_interface.dart';

class GetFavoritesWordsDatasource implements IGetFavoritesWordsDatasource {
  final IFirebaseService _firebaseService;

  GetFavoritesWordsDatasource(this._firebaseService);

  @override
  Future<List<FavoriteWordModel>> getFavoritesWords() async {
    try {
      final response = await _firebaseService.getFavoritesWords();
      return List<FavoriteWordModel>.from(response.map((e) => FavoriteWordModel.fromMap(e)));
    } on FirebaseFailure {
      throw GetFavoritesWordsFailure();
    }
  }
}
