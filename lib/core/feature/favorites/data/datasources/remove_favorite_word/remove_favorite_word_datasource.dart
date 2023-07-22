import 'package:english_dictionary/core/errors/firebase_failure.dart';
import 'package:english_dictionary/core/feature/favorites/core/errors/favorites_failure.dart';
import 'package:english_dictionary/core/feature/favorites/data/datasources/remove_favorite_word/remove_favorite_word_datasource_interface.dart';
import 'package:english_dictionary/core/feature/favorites/data/models/favorites_word_model.dart';
import 'package:english_dictionary/core/services/firebase/firebase_service_interface.dart';

class RemoveFavoriteWordDatasource implements IRemoveFavoriteWordDatasource {
  final IFirebaseService _firebaseService;

  RemoveFavoriteWordDatasource(this._firebaseService);

  @override
  Future<bool> removeFavoriteWord(FavoriteWordModel model) async {
    try {
      return await _firebaseService.removeFavoriteWord(model.toMap());
    } on FirebaseFailure {
      throw RemoveFavoriteWordFailure();
    }
  }
}
