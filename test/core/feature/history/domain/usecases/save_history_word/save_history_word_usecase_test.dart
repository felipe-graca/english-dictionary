import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/history/core/errors/hisotry_failure.dart';
import 'package:english_dictionary/core/feature/history/data/repositories/save_history_word/save_history_word_repository.dart';
import 'package:english_dictionary/core/feature/history/domain/entities/history_word_entity.dart';
import 'package:english_dictionary/core/feature/history/domain/usecases/save_history_word/save_history_word_usecase.dart';
import 'package:english_dictionary/core/feature/history/domain/usecases/save_history_word/save_history_word_usecase_interface.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'save_history_word_usecase_test.mocks.dart';

@GenerateMocks([SaveHistoryWordRepository])
main() {
  final saveHistoryWordRepository = MockSaveHistoryWordRepository();

  final ISaveHistoryWordUsecase saveHistoryWordUsecase = SaveHistoryWordUsecase(saveHistoryWordRepository);

  final faker = Faker();
  final historyWord = HistoryWordEntity(id: faker.guid.guid(), word: faker.lorem.word());

  group(
    'SaveHistoryWordUsecase',
    () {
      test(
        'should return [Right(HistoryWordEntity)] when [SaveHistoryWordRepository.saveHistoryWord()] return [HistoryWordEntity]',
        () async {
          when(saveHistoryWordRepository.saveHistoryWord(historyWord.toModel())).thenAnswer((_) async => Right(historyWord));

          final result = await saveHistoryWordUsecase.call(historyWord);

          expect(result, Right(historyWord));
        },
      );

      test(
        'should return [Left(SaveHistoryWordFailure())] when [SaveHistoryWordRepository.saveHistoryWord()] throw [SaveHistoryWordFailure()]',
        () async {
          when(saveHistoryWordRepository.saveHistoryWord(historyWord.toModel())).thenThrow(SaveHistoryWordFailure());

          final result = await saveHistoryWordUsecase.call(historyWord);

          expect(result, isA<Left<SaveHistoryWordFailure, HistoryWordEntity>>());
        },
      );
    },
  );
}
