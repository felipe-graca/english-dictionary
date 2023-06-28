import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/auth/data/repositores/login_repository.dart';
import 'package:english_dictionary/core/feature/auth/domain/usecases/login_usecase.dart';
import 'package:english_dictionary/core/feature/auth/domain/usecases/login_usecase_interface.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_usecase_test.mocks.dart';

@GenerateMocks([LoginRepository])
main() {
  group('login repository', () {
    test('should return true when logged user', () async {
      final repository = MockLoginRepository();
      final ILoginUsecase usecase = LoginUsecase(repository);
      when(repository.login()).thenAnswer((_) async => const Right(true));

      final result = await usecase(noParams);

      expect(result, const Right(true));
    });

    test('should return false when not logged user', () async {
      final repository = MockLoginRepository();
      final ILoginUsecase usecase = LoginUsecase(repository);
      when(repository.login()).thenAnswer((_) async => Left(LoginFailure()));

      final result = await usecase.call(noParams);

      final folded = result.fold((l) => l, (r) => r);

      expect(folded, isA<LoginFailure>());
    });
  });
}
