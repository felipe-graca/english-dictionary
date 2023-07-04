import 'package:english_dictionary/core/errors/failure.dart';
import 'package:english_dictionary/core/feature/favorites/data/datasources/get_favorites_words/get_favorites_words_datasource_interface.dart';
import 'package:english_dictionary/core/feature/words/core/errors/words_failure.dart';
import 'package:english_dictionary/core/feature/words/data/models/word_model.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
import 'package:english_dictionary/core/services/firebase/firebase_service_interface.dart';

class GetFavoritesWordsDatasource implements IGetFavoritesWordsDatasource {
  final IFirebaseService _firebaseService;

  GetFavoritesWordsDatasource(this._firebaseService);

  @override
  Future<List<WordEntity>> getFavoritesWords() async {
    try {
      final response = await _firebaseService.getFavoritesWords();
      return List<WordEntity>.from(response.map((e) => WordModel.fromMap(e).toEntity()));
    } on FirebaseFailure {
      throw GetFavoritesWordsFailure();
    }
  }
}
