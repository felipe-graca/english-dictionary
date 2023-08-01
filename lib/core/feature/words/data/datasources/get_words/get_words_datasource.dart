import 'package:english_dictionary/core/errors/firebase_failure.dart';
import 'package:english_dictionary/core/feature/words/core/errors/words_failure.dart';
import 'package:english_dictionary/core/feature/words/data/datasources/get_words/get_words_datasource_interface.dart';
import 'package:english_dictionary/core/feature/words/data/models/word_model.dart';
import 'package:english_dictionary/core/services/firebase/firestore_service_interface.dart';

class GetWordsDatasource implements IGetWordsDatasource {
  final IFirestoreService _firestoreService;

  GetWordsDatasource(this._firestoreService);

  @override
  Future<List<WordModel>> getWords() async {
    try {
      final result = await _firestoreService.getWords();
      return result.map((e) => WordModel.fromMap(e)).toList();
    } on FirebaseFailure catch (e) {
      throw GetWordsFailure(message: e.message);
    }
  }
}
