import 'package:english_dictionary/core/errors/firebase_failure.dart';
import 'package:english_dictionary/core/feature/favorites/core/errors/favorites_failure.dart';
import 'package:english_dictionary/core/feature/favorites/data/datasources/get_favorites_words/get_favorites_words_datasource_interface.dart';
import 'package:english_dictionary/core/feature/favorites/data/models/favorites_word_model.dart';
import 'package:english_dictionary/core/services/firestore/firestore_service_interface.dart';

class GetFavoritesWordsDatasource implements IGetFavoritesWordsDatasource {
  final IFirestoreService _firestoreService;

  GetFavoritesWordsDatasource(this._firestoreService);

  @override
  Future<List<FavoriteWordModel>> getFavoritesWords() async {
    try {
      final response = await _firestoreService.getFavoritesWords();
      return List<FavoriteWordModel>.from(response.map((e) => FavoriteWordModel.fromMap(e)));
    } on FirestoreFailure {
      throw GetFavoritesWordsFailure();
    }
  }
}
