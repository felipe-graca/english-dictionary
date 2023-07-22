import 'package:english_dictionary/core/errors/firebase_failure.dart';
import 'package:english_dictionary/core/feature/favorites/core/errors/favorites_failure.dart';
import 'package:english_dictionary/core/feature/favorites/data/datasources/save_favorite_word/save_favorite_word_datasource_interface.dart';
import 'package:english_dictionary/core/feature/favorites/data/models/favorites_word_model.dart';
import 'package:english_dictionary/core/services/firebase/firebase_service_interface.dart';

class SaveFavoriteWordDatasource implements ISaveFavoriteWordDatasource {
  final IFirebaseService _firebaseService;

  SaveFavoriteWordDatasource(this._firebaseService);

  @override
  Future<bool> saveFavoriteWord(FavoriteWordModel model) async {
    try {
      return await _firebaseService.saveFavoriteWord(model.toMap());
    } on FirebaseFailure {
      throw SaveFavoriteWordFailure();
    }
  }
}
