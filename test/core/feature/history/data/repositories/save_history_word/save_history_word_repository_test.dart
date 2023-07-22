import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/history/core/errors/hisotry_failure.dart';
import 'package:english_dictionary/core/feature/history/data/datasources/save_history_word/save_history_word_datasource.dart';
import 'package:english_dictionary/core/feature/history/data/repositories/save_history_word/save_history_word_repository.dart';
import 'package:english_dictionary/core/feature/history/domain/entities/history_word_entity.dart';
import 'package:english_dictionary/core/feature/history/domain/repositories/save_history_word/save_history_word_interface.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'save_history_word_repository_test.mocks.dart';

@GenerateMocks([SaveHistoryWordDatasource])
main() {
  final saveHistoryWordDatasource = MockSaveHistoryWordDatasource();

  final ISaveHistoryWordRepository saveHistoryWordRepository = SaveHistoryWordRepository(saveHistoryWordDatasource);

  final faker = Faker();
  final historyWord = HistoryWordEntity(id: faker.guid.guid(), word: faker.lorem.word());

  group(
    'saveHistoryWord()',
    () {
      test(
        'should return [Right(HistoryWordEntity)] when [SaveHistoryWordDatasource.saveHistoryWord()] return [HistoryWordEntity]',
        () async {
          when(saveHistoryWordDatasource.saveHistoryWord(historyWord.toModel())).thenAnswer((_) async => true);

          final result = await saveHistoryWordRepository.saveHistoryWord(historyWord);

          expect(result, Right(historyWord));
        },
      );

      test(
        'should return [Left(SaveHistoryWordFailure())] when [SaveHistoryWordDatasource.saveHistoryWord()] throw [SaveHistoryWordFailure()]',
        () async {
          when(saveHistoryWordDatasource.saveHistoryWord(historyWord.toModel())).thenThrow(SaveHistoryWordFailure());

          final result = await saveHistoryWordRepository.saveHistoryWord(historyWord);

          expect(result, isA<Left<SaveHistoryWordFailure, HistoryWordEntity>>());
        },
      );
    },
  );
}
