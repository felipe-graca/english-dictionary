import 'package:english_dictionary/core/errors/firebase_failure.dart';
import 'package:english_dictionary/core/feature/history/core/errors/hisotry_failure.dart';
import 'package:english_dictionary/core/feature/history/data/datasources/clear_history_words/clear_history_words_datasource_interface.dart';
import 'package:english_dictionary/core/services/firebase/firestore_service_interface.dart';

class ClearHistoryWordsDatasource implements IClearHistoryWordsDatasource {
  final IFirestoreService _firestoreService;

  ClearHistoryWordsDatasource(this._firestoreService);

  @override
  Future<bool> clearHistoryWords() async {
    try {
      return _firestoreService.clearHistoryWords();
    } on FirebaseFailure {
      throw ClearHistoryWordsFailure();
    }
  }
}
