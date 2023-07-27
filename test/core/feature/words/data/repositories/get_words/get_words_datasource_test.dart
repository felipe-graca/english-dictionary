import 'package:english_dictionary/core/feature/words/core/errors/words_failure.dart';
import 'package:english_dictionary/core/feature/words/data/datasources/get_words/get_words_datasource.dart';
import 'package:english_dictionary/core/feature/words/data/models/word_model.dart';
import 'package:english_dictionary/core/feature/words/data/repositories/get_words/get_words_repository.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
import 'package:english_dictionary/core/feature/words/domain/repositories/get_words/get_words_repository_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_words_datasource_test.mocks.dart';

@GenerateMocks([GetWordsDatasource])
main() {
  final datasource = MockGetWordsDatasource();
  final IGetWordsRepository repository = GetWordsRepository(datasource);

  test('should return a list of words', () async {
    when(datasource.getWords()).thenAnswer((_) async => <WordModel>[]);
    final (failure, result) = await repository.getWords();

    expect(result, isA<List<WordEntity>>());
    expect(result, <WordEntity>[]);
    expect(failure, isNull);

    verify(datasource.getWords()).called(1);
    verifyNoMoreInteractions(datasource);
  });

  test('should return a failure', () async {
    when(datasource.getWords()).thenThrow(GetWordsFailure());
    final (failure, result) = await repository.getWords();

    expect(result, <WordEntity>[]);
    expect(failure, isA<GetWordsFailure>());
  });
}
