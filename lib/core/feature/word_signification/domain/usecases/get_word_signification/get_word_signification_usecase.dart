import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/word_signification/core/errors/word_signification_failure.dart';
import 'package:english_dictionary/core/feature/word_signification/data/repositories/get_word_signification/get_word_signification_trpository_interface.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/entities/word_signification_entity.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/usecases/get_word_signification/get_word_signification_usecase_interface.dart';

class GetWordSignificationUsecase implements IGetWordSignificationUsecase {
  final IGetWordSignificationRepository _repository;

  GetWordSignificationUsecase(this._repository);

  @override
  Future<Either<GetWordSignificationFailure, WordSignificationEntity>> call(String params) async {
    try {
      final result = await _repository.getWordSignification(params);
      return result.fold(
        (failure) => throw failure,
        (success) => Right(success),
      );
    } on GetWordSignificationFailure catch (e) {
      return Left(e);
    }
  }
}
