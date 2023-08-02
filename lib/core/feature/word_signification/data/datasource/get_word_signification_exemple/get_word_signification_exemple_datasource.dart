import 'package:dio/dio.dart';
import 'package:english_dictionary/core/feature/word_signification/core/errors/word_signification_failure.dart';
import 'package:english_dictionary/core/feature/word_signification/core/services/rapidapi/rapidapi_service_interface.dart';
import 'package:english_dictionary/core/feature/word_signification/data/datasource/get_word_signification_exemple/get_word_signification_exemple_datasource_interface.dart';
import 'package:english_dictionary/core/feature/word_signification/data/model/exemple_model.dart';

class GetWordSignificationExampleDatasource implements IGetWordSignificationExampleDatasource {
  final IRapidapiService _rapidapiService;

  GetWordSignificationExampleDatasource(this._rapidapiService);

  @override
  Future<ExampleModel> getWordSignificationExamples(String word) async {
    const url = "https://wordsapiv1.p.rapidapi.com/words";
    try {
      final response = await _rapidapiService.get("$url/$word/examples");
      return ExampleModel.fromMap(response.data);
    } on DioException catch (e) {
      throw GetWordSignificationExampleFailure(message: e.message ?? 'error on getWordSignificationExamples');
    }
  }
}
