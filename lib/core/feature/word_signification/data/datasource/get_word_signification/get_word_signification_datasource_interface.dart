import 'package:english_dictionary/core/feature/word_signification/data/model/signification_request_model.dart';

abstract interface class IGetWordSignificationDatasource {
  Future<String> getWordSignification(SignificationRequestModel request);
}
