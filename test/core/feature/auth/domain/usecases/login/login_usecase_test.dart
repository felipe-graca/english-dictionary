import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/auth/data/repositores/login/login_repository.dart';
import 'package:english_dictionary/core/feature/auth/domain/usecases/login/login_usecase.dart';
import 'package:english_dictionary/core/feature/auth/domain/usecases/login/login_usecase_interface.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_usecase_test.mocks.dart';

@GenerateMocks([LoginRepository])
main() {
  final repository = MockLoginRepository();
  final ILoginUsecase usecase = LoginUsecase(repository);

  test('should return true when logged user', () async {
    when(repository.login()).thenAnswer((_) async => (null, true));

    final (failure, result) = await usecase.call(noParams);

    expect(failure, null);
    expect(result, true);
  });

  test('should return false when not logged user', () async {
    when(repository.login()).thenAnswer((_) async => (LoginFailure(), false));

    final (failure, result) = await usecase.call(noParams);

    expect(failure, isA<LoginFailure>());
    expect(result, false);
  });
}
