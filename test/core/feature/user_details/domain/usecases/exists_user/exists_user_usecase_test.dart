import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
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
      when(existsUserRepository.existsUser()).thenAnswer((_) async => const Right(true));

      final result = await existsUserUsecase.call(noParams);

      expect(result, isA<Right<ExistsUserFailuire, bool>>());
      expect(result, const Right<ExistsUserFailuire, bool>(true));
    });

    test('existsUser() should return false when user not exists', () async {
      when(existsUserRepository.existsUser()).thenAnswer((_) async => const Right(false));

      final result = await existsUserUsecase.call(noParams);

      expect(result, isA<Right<ExistsUserFailuire, bool>>());
      expect(result, const Right<ExistsUserFailuire, bool>(false));
    });
  });
}
