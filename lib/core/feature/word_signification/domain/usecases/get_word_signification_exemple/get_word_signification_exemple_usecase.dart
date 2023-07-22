import 'package:english_dictionary/core/feature/word_signification/core/errors/word_signification_failure.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/entities/exemple_entity.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/repositories/get_word_signification_exemple/get_word_signification_exemple_repository.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/usecases/get_word_signification_exemple/get_word_signification_exemple_usecase_interface.dart';

class GetWordSignificationExampleUsecase implements IGetWordSignificationExampleUsecase {
  final IGetWordSignificationExampleRepository _repository;

  GetWordSignificationExampleUsecase(this._repository);
  @override
  Future<(GetWordSignificationExampleFailure?, ExampleEntity)> call(String word) async => await _repository.getWordSignificationExamples(word);
}
