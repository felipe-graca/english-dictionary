import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/auth/data/datasource/login_datasource.dart';
import 'package:english_dictionary/core/feature/auth/data/repositores/login_repository.dart';
import 'package:english_dictionary/core/feature/auth/domain/repositores/login_repository_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_repository_test.mocks.dart';

@GenerateMocks([LoginDatasource])
main() {
  group('login repository', () {
    test('should return true when logged user', () async {
      final datasource = MockLoginDatasource();
      final ILoginRepository repository = LoginRepository(datasource);
      when(repository.login()).thenAnswer((_) async => const Right(true));
    });

    test('should return false when not logged user', () async {
      final datasource = MockLoginDatasource();
      final ILoginRepository repository = LoginRepository(datasource);
      when(repository.login()).thenAnswer((_) async => Left(LoginFailure()));
    });
  });
}
