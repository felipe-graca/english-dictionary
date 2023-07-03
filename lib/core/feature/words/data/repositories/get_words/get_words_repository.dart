import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/errors/failure.dart';
import 'package:english_dictionary/core/feature/words/data/datasources/get_words/get_words_datasource_interface.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
import 'package:english_dictionary/core/feature/words/domain/repositories/get_words/get_words_repository_interface.dart';

class GetWordsRepository implements IGetWordsRepository {
  final IGetWordsDatasource _datasource;

  GetWordsRepository(this._datasource);
  @override
  Future<Either<Failure, List<WordEntity>>> getWords() async {
    try {
      final result = await _datasource.getWords();
      return Right(List<WordEntity>.from(result.map((e) => e.toEntity())));
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
