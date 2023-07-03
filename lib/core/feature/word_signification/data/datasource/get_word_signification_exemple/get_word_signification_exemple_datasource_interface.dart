import 'package:english_dictionary/core/feature/word_signification/data/model/exemple_model.dart';

abstract interface class IGetWordSignificationExampleDatasource {
  Future<ExampleModel> getWordSignificationExamples(String word);
}
