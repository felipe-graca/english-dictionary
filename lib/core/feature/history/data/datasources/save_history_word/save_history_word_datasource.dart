import 'package:english_dictionary/core/errors/failure.dart';
import 'package:english_dictionary/core/feature/history/core/errors/hisotry_failure.dart';
import 'package:english_dictionary/core/feature/words/data/models/word_model.dart';
import 'package:english_dictionary/core/services/firebase/firebase_service_interface.dart';

import 'save_history_word_datasource_interface.dart';

class SaveHistoryWordDatasource implements ISaveHistoryWordDatasource {
  final IFirebaseService _firebaseService;

  SaveHistoryWordDatasource(this._firebaseService);

  @override
  Future<WordModel> saveFavoriteWord(WordModel model) async {
    try {
      final result = await _firebaseService.saveHistoryWord(model.toMap());
      return WordModel.fromMap(result);
    } on FirebaseFailure {
      throw SaveHistoryWordFailure();
    }
  }
}
