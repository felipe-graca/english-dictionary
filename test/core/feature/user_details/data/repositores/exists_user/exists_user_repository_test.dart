import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/user_details/data/datasources/exists_user/exists_user_datasource_interface.dart';
import 'package:english_dictionary/core/feature/user_details/data/repositories/exists_user/exists_user_repository.dart';
import 'package:english_dictionary/core/feature/user_details/domain/repositories/exists_user/exists_user_repository_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'exists_user_repository_test.mocks.dart';

@GenerateMocks([ExistsUserDatasource])
main() {
  final existsUserDatasource = MockExistsUserDatasource();
  final IExistsUserRepository existsUserRepository = ExistsUserRepository(existsUserDatasource);

  group('existsUser()', () {
    test('existsUser() should return true when user exists', () async {
      when(existsUserDatasource.existsUser()).thenAnswer((_) async => true);

      final result = await existsUserRepository.existsUser();

      expect(result, isA<Right<ExistsUserFailuire, bool>>());
    });

    test('existsUser() should return false when user not exists', () async {
      when(existsUserDatasource.existsUser()).thenAnswer((_) async => false);

      final result = await existsUserRepository.existsUser();

      expect(result, isA<Right<ExistsUserFailuire, bool>>());
    });
  });
}
