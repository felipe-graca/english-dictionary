import 'package:english_dictionary/core/errors/firebase_failure.dart';
import 'package:english_dictionary/core/feature/history/core/errors/hisotry_failure.dart';
import 'package:english_dictionary/core/feature/history/data/models/history_word_model.dart';
import 'package:english_dictionary/core/services/firebase/firebase_service_interface.dart';

import 'save_history_word_datasource_interface.dart';

class SaveHistoryWordDatasource implements ISaveHistoryWordDatasource {
  final IFirebaseService _firebaseService;

  SaveHistoryWordDatasource(this._firebaseService);

  @override
  Future<bool> saveHistoryWord(HistoryWordModel model) async {
    try {
      return await _firebaseService.saveHistoryWord(model.toMap());
    } on FirebaseFailure {
      throw SaveHistoryWordFailure();
    }
  }
}
