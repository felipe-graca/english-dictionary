import 'package:english_dictionary/core/errors/failure.dart';
import 'package:english_dictionary/core/feature/words/core/errors/words_failure.dart';
import 'package:english_dictionary/core/feature/words/data/datasources/save_favorite_word/save_favorite_word_datasource_interface.dart';
import 'package:english_dictionary/core/feature/words/data/models/word_model.dart';
import 'package:english_dictionary/core/services/firebase/firebase_service_interface.dart';

class SaveFavoriteWordDatasource implements ISaveFavoriteWordDatasource {
  final IFirebaseService _firebaseService;

  SaveFavoriteWordDatasource(this._firebaseService);

  @override
  Future<WordModel> saveFavoriteWord(WordModel model) async {
    try {
      final result = await _firebaseService.saveFavoriteWord(model.toMap());
      return WordModel.fromMap(result);
    } on FirebaseFailure {
      throw SaveFavoriteWordFailure();
    }
  }
}
