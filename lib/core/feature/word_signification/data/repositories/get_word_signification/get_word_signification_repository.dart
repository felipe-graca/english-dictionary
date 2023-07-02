import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/word_signification/core/errors/word_signification_failure.dart';
import 'package:english_dictionary/core/feature/word_signification/data/datasource/get_word_signification/get_word_signification_datasource_interface.dart';
import 'package:english_dictionary/core/feature/word_signification/data/repositories/get_word_signification/get_word_signification_trpository_interface.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/entities/word_signification_entity.dart';

class GetWordSignificationRepository implements IGetWordSignificationRepository {
  final IGetWordSignificationDatasource datasource;

  GetWordSignificationRepository(this.datasource);

  @override
  Future<Either<GetWordSignificationFailure, WordSignificationEntity>> getWordSignification(String word) async {
    try {
      final result = await datasource.getWordSignification(word);
      return Right(result.toEntity());
    } on GetWordSignificationFailure catch (e) {
      return Left(e);
    }
  }
}
