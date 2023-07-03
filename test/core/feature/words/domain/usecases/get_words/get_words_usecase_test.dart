import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/words/core/errors/words_failure.dart';
import 'package:english_dictionary/core/feature/words/data/repositories/get_words/get_words_repository.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
import 'package:english_dictionary/core/feature/words/domain/usecases/get_words/get_words_usecase.dart';
import 'package:english_dictionary/core/feature/words/domain/usecases/get_words/get_words_usecase_interface.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_words_usecase_test.mocks.dart';

@GenerateMocks([GetWordsRepository])
void main() {
  final repository = MockGetWordsRepository();
  final IGetWordsUsecase usecase = GetWordsUsecase(repository);

  test('should get words from repository', () async {
    when(repository.getWords()).thenAnswer((_) async => const Right(<WordEntity>[]));

    final result = await usecase.call(noParams);

    expect(result, const Right(<WordEntity>[]));
    verify(repository.getWords());
    verifyNoMoreInteractions(repository);
  });

  test('should get GetWordsFailure from repository', () async {
    when(repository.getWords()).thenAnswer((_) async => Left(GetWordsFailure()));

    final result = await usecase.call(noParams);

    expect(result.isLeft(), true);
    verify(repository.getWords());
    verifyNoMoreInteractions(repository);
  });
}
