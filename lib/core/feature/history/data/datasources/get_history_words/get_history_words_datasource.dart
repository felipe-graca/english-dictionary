import 'package:english_dictionary/core/errors/firebase_failure.dart';
import 'package:english_dictionary/core/feature/history/core/errors/hisotry_failure.dart';
import 'package:english_dictionary/core/feature/history/data/datasources/get_history_words/get_history_words_datasource_interface.dart';
import 'package:english_dictionary/core/feature/history/data/models/history_word_model.dart';
import 'package:english_dictionary/core/services/firebase/firestore_service_interface.dart';

class GetHistoryWordsDatasource implements IGetHistoryWordsDatasource {
  final IFirestoreService _firestoreService;

  GetHistoryWordsDatasource(this._firestoreService);

  @override
  Future<List<HistoryWordModel>> getHistoryWords() async {
    try {
      final response = await _firestoreService.getHistoryWords();
      return List<HistoryWordModel>.from(response.map((e) => HistoryWordModel.fromMap(e)));
    } on FirebaseFailure {
      throw GetHistoryWordsFailure();
    }
  }
}
