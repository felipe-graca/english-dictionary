import 'package:english_dictionary/core/errors/firebase_failure.dart';
import 'package:english_dictionary/core/feature/history/core/errors/hisotry_failure.dart';
import 'package:english_dictionary/core/feature/history/data/datasources/clear_history_words/clear_history_words_datasource_interface.dart';
import 'package:english_dictionary/core/services/firebase/firebase_service_interface.dart';

class ClearHistoryWordsDatasource implements IClearHistoryWordsDatasource {
  final IFirebaseService _firebaseService;

  ClearHistoryWordsDatasource(this._firebaseService);

  @override
  Future<bool> clearHistoryWords() async {
    try {
      return _firebaseService.clearHistoryWords();
    } on FirebaseFailure {
      throw ClearHistoryWordsFailure();
    }
  }
}
