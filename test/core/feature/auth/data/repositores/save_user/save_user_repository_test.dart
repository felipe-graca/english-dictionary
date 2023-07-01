import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/auth/data/repositores/save_user_repository.dart';
import 'package:english_dictionary/core/feature/auth/domain/entities/user_data_entity.dart';
import 'package:english_dictionary/core/feature/auth/domain/repositores/save_user_repository_interface.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'save_user_repository_test.mocks.dart';

void main() {
  final faker = Faker();

  final userDataEntity = UserDataEntity(
    name: faker.person.name(),
    email: faker.internet.email(),
    base64Image: faker.image.toString(),
    uid: faker.guid.guid(),
    history: const [],
  );

  final datasource = MockSaveUserDatasource();
  final ISaveUserRepository repository = SaveUserRepository(datasource);

  test(
    'should return true when saved user',
    () async {
      when(datasource.saveUser(userDataEntity.toModel())).thenAnswer((_) async => true);
      final result = await repository.saveUser(userDataEntity);

      expect(result, const Right(true));
    },
  );

  test(
    'should return throw when not saved user',
    () async {
      when(datasource.saveUser(userDataEntity.toModel())).thenThrow(SaveUserFailure());
      final result = await repository.saveUser(userDataEntity);

      expect(result, isA<Left<SaveUserFailure, bool>>());
    },
  );
}