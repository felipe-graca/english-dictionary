import 'package:english_dictionary/core/errors/firebase_failure.dart';
import 'package:english_dictionary/core/feature/history/core/errors/hisotry_failure.dart';
import 'package:english_dictionary/core/feature/history/data/models/history_word_model.dart';
import 'package:english_dictionary/core/services/firestore/firestore_service_interface.dart';

import 'save_history_word_datasource_interface.dart';

class SaveHistoryWordDatasource implements ISaveHistoryWordDatasource {
  final IFirestoreService _firestoreService;

  SaveHistoryWordDatasource(this._firestoreService);

  @override
  Future<bool> saveHistoryWord(HistoryWordModel model) async {
    try {
      return await _firestoreService.saveHistoryWord(model.toMap());
    } on FirestoreFailure {
      throw SaveHistoryWordFailure();
    }
  }
}
