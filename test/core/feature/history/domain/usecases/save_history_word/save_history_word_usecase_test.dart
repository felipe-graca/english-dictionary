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
          when(saveHistoryWordRepository.saveHistoryWord(historyWord.toModel())).thenAnswer((_) async => (null, true));

          final (failure, result) = await saveHistoryWordUsecase.call(historyWord);

          expect(result, true);
          expect(failure, null);

          verify(saveHistoryWordRepository.saveHistoryWord(historyWord)).called(1);
          verifyNoMoreInteractions(saveHistoryWordRepository);
        },
      );

      test(
        'should return [Left(SaveHistoryWordFailure())] when [SaveHistoryWordRepository.saveHistoryWord()] throw [SaveHistoryWordFailure()]',
        () async {
          when(saveHistoryWordRepository.saveHistoryWord(historyWord.toModel())).thenAnswer((_) async => (SaveHistoryWordFailure(), false));

          final (failure, result) = await saveHistoryWordUsecase.call(historyWord);

          expect(result, false);
          expect(failure, isA<SaveHistoryWordFailure>());

          verify(saveHistoryWordRepository.saveHistoryWord(historyWord)).called(1);
          verifyNoMoreInteractions(saveHistoryWordRepository);
        },
      );
    },
  );
}
