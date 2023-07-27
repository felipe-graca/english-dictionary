import 'package:english_dictionary/core/feature/history/core/errors/hisotry_failure.dart';
import 'package:english_dictionary/core/feature/history/data/datasources/get_history_words/get_history_words_datasource.dart';
import 'package:english_dictionary/core/feature/history/data/repositories/get_history_words/get_history_words_repository.dart';
import 'package:english_dictionary/core/feature/history/domain/entities/history_word_entity.dart';
import 'package:english_dictionary/core/feature/history/domain/repositories/get_history_words/get_history_words_repository_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_history_words_repository_test.mocks.dart';

@GenerateMocks([GetHistoryWordsDatasource])
main() {
  final getHistoryWordsDatasource = MockGetHistoryWordsDatasource();

  final IGetHistoryWordsRepository getHistoryWordsRepository = GetHistoryWordsRepository(getHistoryWordsDatasource);

  group(
    'getHistoryWords()',
    () {
      test(
        'should return [Right(List<HistoryWordEntity>)] when [GetHistoryWordsDatasource.getHistoryWords()] return [List<HistoryWordEntity>]',
        () async {
          when(getHistoryWordsDatasource.getHistoryWords()).thenAnswer((_) async => []);

          final (failure, result) = await getHistoryWordsRepository.getHistoryWords();

          expect(result, isA<List<HistoryWordEntity>>());
          expect(result, []);
          expect(failure, isNull);

          verify(getHistoryWordsDatasource.getHistoryWords()).called(1);
          verifyNoMoreInteractions(getHistoryWordsDatasource);
        },
      );

      test(
        'should return [Left(GetHistoryWordsFailure())] when [GetHistoryWordsDatasource.getHistoryWords()] throw [GetHistoryWordsFailure()]',
        () async {
          when(getHistoryWordsDatasource.getHistoryWords()).thenThrow(GetHistoryWordsFailure());

          final (failure, result) = await getHistoryWordsRepository.getHistoryWords();

          expect(result, []);
          expect(failure, isA<GetHistoryWordsFailure>());

          verify(getHistoryWordsDatasource.getHistoryWords()).called(1);
          verifyNoMoreInteractions(getHistoryWordsDatasource);
        },
      );
    },
  );
}
