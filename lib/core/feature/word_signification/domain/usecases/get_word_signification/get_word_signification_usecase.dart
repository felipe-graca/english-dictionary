import 'package:english_dictionary/core/feature/word_signification/core/errors/word_signification_failure.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/repositories/get_word_signification/get_word_signification_repository_interface.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/entities/word_signification_entity.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/usecases/get_word_signification/get_word_signification_usecase_interface.dart';

class GetWordSignificationUsecase implements IGetWordSignificationUsecase {
  final IGetWordSignificationRepository _repository;

  GetWordSignificationUsecase(this._repository);

  @override
  Future<(GetWordSignificationFailure?, WordSignificationEntity)> call(String params) async => await _repository.getWordSignification(params);
}
