import 'package:english_dictionary/core/feature/history/core/errors/hisotry_failure.dart';
import 'package:english_dictionary/core/feature/history/data/repositories/get_history_words/get_history_words_repository.dart';
import 'package:english_dictionary/core/feature/history/domain/entities/history_word_entity.dart';
import 'package:english_dictionary/core/feature/history/domain/usecases/get_history_words/get_history_words_usecase.dart';
import 'package:english_dictionary/core/feature/history/domain/usecases/get_history_words/get_history_words_usecase_interface.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_history_words_usecase_test.mocks.dart';

@GenerateMocks([GetHistoryWordsRepository])
main() {
  final getHistoryWordsRepository = MockGetHistoryWordsRepository();

  final IGetHistoryWordsUsecase getHistoryWordsUsecase = GetHistoryWordsUsecase(getHistoryWordsRepository);

  group(
    'GetHistoryWordsUsecase',
    () {
      test(
        'should return [Right(List<HistoryWordEntity>)] when [GetHistoryWordsRepository.getHistoryWords()] return [List<HistoryWordEntity>]',
        () async {
          when(getHistoryWordsRepository.getHistoryWords()).thenAnswer((_) async => (null, <HistoryWordEntity>[]));

          final (failure, result) = await getHistoryWordsUsecase.call(noParams);

          expect(result, <HistoryWordEntity>[]);
          expect(failure, null);

          verify(getHistoryWordsRepository.getHistoryWords()).called(1);
          verifyNoMoreInteractions(getHistoryWordsRepository);
        },
      );

      test(
        'should return [Left(GetHistoryWordsFailure())] when [GetHistoryWordsRepository.getHistoryWords()] throw [GetHistoryWordsFailure()]',
        () async {
          when(getHistoryWordsRepository.getHistoryWords()).thenAnswer((_) async => (GetHistoryWordsFailure(), <HistoryWordEntity>[]));

          final (failure, result) = await getHistoryWordsUsecase.call(noParams);

          expect(result, <HistoryWordEntity>[]);
          expect(failure, isA<GetHistoryWordsFailure>());

          verify(getHistoryWordsRepository.getHistoryWords()).called(1);
          verifyNoMoreInteractions(getHistoryWordsRepository);
        },
      );
    },
  );
}
