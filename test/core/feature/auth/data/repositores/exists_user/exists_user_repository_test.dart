import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/auth/data/datasource/exists_user/exists_user_datasource_interface.dart';
import 'package:english_dictionary/core/feature/auth/data/repositores/exists_user/exists_user_repository.dart';
import 'package:english_dictionary/core/feature/auth/domain/repositores/exists_user/exists_user_repository_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'exists_user_repository_test.mocks.dart';

@GenerateMocks([ExistsUserDatasource])
void main() {
  group('Exisrs user repository', () {
    test(
      'should return true when saved user',
      () async {
        final datasource = MockExistsUserDatasource();
        when(datasource.existsUser()).thenAnswer((_) async => true);
        final IExistsUserRepository repository = ExistsUserRepository(datasource);

        final result = await repository.existsUser();

        expect(result, const Right(true));
      },
    );

    test(
      'should return throw when not saved user',
      () async {
        final datasource = MockExistsUserDatasource();
        when(datasource.existsUser()).thenThrow(ExistsUserFailuire());
        final IExistsUserRepository repository = ExistsUserRepository(datasource);

        final result = await repository.existsUser();

        expect(result, isA<Left<ExistsUserFailuire, bool>>());
      },
    );
  });
}
