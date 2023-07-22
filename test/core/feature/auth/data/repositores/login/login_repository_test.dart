import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/auth/data/datasource/login/login_datasource.dart';
import 'package:english_dictionary/core/feature/auth/data/repositores/login/login_repository.dart';
import 'package:english_dictionary/core/feature/auth/domain/repositores/login/login_repository_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_repository_test.mocks.dart';

@GenerateMocks([LoginDatasource])
main() {
  group('login repository', () {
    test('should return true when logged user', () async {
      final datasource = MockLoginDatasource();
      when(datasource.login()).thenAnswer((_) async => true);
      final ILoginRepository repository = LoginRepository(datasource);

      final (failure, result) = await repository.login();

      expect(result, true);
      expect(failure, null);
    });

    test('should return trow when not logged user', () async {
      final datasource = MockLoginDatasource();
      when(datasource.login()).thenThrow(LoginFailure());
      final ILoginRepository repository = LoginRepository(datasource);

      final (failure, result) = await repository.login();

      expect(failure, isA<LoginFailure>());
      expect(result, false);
    });
  });
}
