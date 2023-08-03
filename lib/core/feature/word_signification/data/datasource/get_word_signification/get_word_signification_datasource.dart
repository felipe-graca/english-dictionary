import 'package:dio/dio.dart';
import 'package:english_dictionary/core/feature/word_signification/core/errors/word_signification_failure.dart';
import 'package:english_dictionary/core/feature/word_signification/data/datasource/get_word_signification/get_word_signification_datasource_interface.dart';
import 'package:english_dictionary/core/feature/word_signification/data/model/signification_request_model.dart';
import 'package:english_dictionary/core/services/gpt/gpt_service_interface.dart';

class GetWordSignificationDatasource implements IGetWordSignificationDatasource {
  final IGptService _service;

  GetWordSignificationDatasource(this._service);

  @override
  Future<String> getWordSignification(SignificationRequestModel request) async {
    try {
      return await _service.generateSignificationText(request);
    } on DioException {
      throw GetWordSignificationExampleFailure();
    }
  }
}
