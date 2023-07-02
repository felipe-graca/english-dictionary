import 'package:english_dictionary/core/feature/word_signification/data/model/word_signification_model.dart';

abstract interface class IGetWordSignificationDatasource {
  Future<WordSignificationModel> getWordSignification(String word);
}
