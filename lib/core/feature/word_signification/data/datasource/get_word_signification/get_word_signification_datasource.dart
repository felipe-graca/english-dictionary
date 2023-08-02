import 'package:dio/dio.dart';
import 'package:english_dictionary/core/feature/word_signification/core/errors/word_signification_failure.dart';
import 'package:english_dictionary/core/feature/word_signification/core/services/rapidapi/rapidapi_service_interface.dart';
import 'package:english_dictionary/core/feature/word_signification/data/datasource/get_word_signification/get_word_signification_datasource_interface.dart';
import 'package:english_dictionary/core/feature/word_signification/data/model/word_signification_model.dart';

class GetWordSignificationDatasource implements IGetWordSignificationDatasource {
  final IRapidapiService _rapidapiService;

  GetWordSignificationDatasource(this._rapidapiService);

  @override
  Future<WordSignificationModel> getWordSignification(String word) async {
    const url = "https://wordsapiv1.p.rapidapi.com/words";
    try {
      final response = await _rapidapiService.get("$url/$word");
      return WordSignificationModel.fromMap(response.data);
    } on DioException catch (e) {
      throw GetWordSignificationFailure(message: e.message ?? 'error on getWordSignification');
    }
  }
}
