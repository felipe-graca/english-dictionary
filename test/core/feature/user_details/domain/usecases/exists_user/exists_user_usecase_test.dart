import 'package:english_dictionary/core/feature/user_details/data/repositories/exists_user/exists_user_repository.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/exists_user/exists_user_usecase.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/exists_user/exists_user_usecase_interface.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'exists_user_usecase_test.mocks.dart';

@GenerateMocks([ExistsUserRepository])
main() {
  final existsUserRepository = MockExistsUserRepository();
  final IExistsUserUsecase existsUserUsecase = ExistsUserUsecase(existsUserRepository);

  group('existsUser()', () {
    test('existsUser() should return true when user exists', () async {
      when(existsUserRepository.existsUser()).thenAnswer((_) async => (null, true));

      final (failure, result) = await existsUserUsecase.call(noParams);

      expect(result, true);
      expect(failure, isNull);

      verify(existsUserRepository.existsUser()).called(1);
      verifyNoMoreInteractions(existsUserRepository);
    });

    test('existsUser() should return false when user not exists', () async {
      when(existsUserRepository.existsUser()).thenAnswer((_) async => (null, false));

      final (failure, result) = await existsUserUsecase.call(noParams);

      expect(result, false);
      expect(failure, isNull);

      verify(existsUserRepository.existsUser()).called(1);
      verifyNoMoreInteractions(existsUserRepository);
    });
  });
}
