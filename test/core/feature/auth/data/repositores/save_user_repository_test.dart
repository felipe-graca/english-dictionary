import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/auth/data/datasource/save_user_data/save_user_data.dart';
import 'package:english_dictionary/core/feature/auth/data/repositores/save_user_repository.dart';
import 'package:english_dictionary/core/feature/auth/domain/repositores/save_user_repository_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../domain/entities/user_data_entity_test.dart';
import 'save_user_repository_test.mocks.dart';

@GenerateMocks([SaveUserDatasource])
void main() {
  group(
    'save user repository',
    () {
      test(
        'should return true when saved user',
        () async {
          final datasource = MockSaveUserDatasource();
          final ISaveUserRepository repository = SaveUserRepository(datasource);
          when(repository.saveUser(userDataEntity)).thenAnswer((_) async => const Right(true));
        },
      );

      test(
        'should return false when not saved user',
        () async {
          final datasource = MockSaveUserDatasource();
          final ISaveUserRepository repository = SaveUserRepository(datasource);
          when(repository.saveUser(userDataEntity)).thenAnswer((_) async => Left(SaveUserFailure()));
        },
      );
    },
  );
}
