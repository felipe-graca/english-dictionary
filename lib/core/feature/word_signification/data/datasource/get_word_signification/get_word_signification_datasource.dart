import 'package:english_dictionary/core/feature/word_signification/data/datasource/get_word_signification/get_word_signification_datasource_interface.dart';
import 'package:english_dictionary/core/feature/word_signification/data/model/word_signification_model.dart';

class GetWordSignificationDatasource implements IGetWordSignificationDatasource {
  // final IHttpService httpService;

  // GetWordSignificationDatasource(this.httpService);

  @override
  Future<WordSignificationModel> getWordSignification(String word) async {
    return const WordSignificationModel();
  }
}
