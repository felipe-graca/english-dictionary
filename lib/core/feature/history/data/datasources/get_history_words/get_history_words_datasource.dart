import 'package:english_dictionary/core/errors/failure.dart';
import 'package:english_dictionary/core/feature/history/core/errors/hisotry_failure.dart';
import 'package:english_dictionary/core/feature/history/data/datasources/get_history_words/get_history_words_datasource_interface.dart';
import 'package:english_dictionary/core/feature/history/data/models/history_word_model.dart';
import 'package:english_dictionary/core/services/firebase/firebase_service_interface.dart';

class GetHistoryWordsDatasource implements IGetHistoryWordsDatasource {
  final IFirebaseService _firebaseService;

  GetHistoryWordsDatasource(this._firebaseService);

  @override
  Future<List<HistoryWordModel>> getHistoryWords() async {
    try {
      final response = await _firebaseService.getHistoryWords();
      return List<HistoryWordModel>.from(response.map((e) => HistoryWordModel.fromMap(e)));
    } on FirebaseFailure {
      throw GetHistoryWordsFailure();
    }
  }
}
