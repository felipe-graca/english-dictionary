import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/user_details/core/errors/user_details_failure.dart';
import 'package:english_dictionary/core/feature/user_details/data/datasources/save_user/save_user_datasource.dart';
import 'package:english_dictionary/core/feature/user_details/data/repositories/save_user/save_user_repository.dart';
import 'package:english_dictionary/core/feature/user_details/domain/entities/user_details_entity.dart';
import 'package:english_dictionary/core/feature/user_details/domain/repositories/save_user/save_user_repository_interface.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'save_user_repository_test.mocks.dart';

@GenerateMocks([SaveUserDatasource])
main() {
  final saveUserDatasource = MockSaveUserDatasource();

  final ISaveUserRepository saveUserRepository = SaveUserRepository(saveUserDatasource);

  final faker = Faker();
  final userDetails = UserDetailsEntity(
    name: faker.person.name(),
    email: faker.internet.email(),
    base64Image: faker.internet.httpUrl(),
    uid: faker.guid.guid(),
  );

  test('Should return true with user was saved with success', () async {
    when(saveUserDatasource.saveUser(userDetails.toModel())).thenAnswer((_) async => true);

    final result = await saveUserRepository.saveUser(userDetails);

    expect(result, isA<Right<SaveUserFailure, bool>>());
    expect(result, const Right(true));
  });

  test('Should return failure when saveUser is failure', () async {
    when(saveUserDatasource.saveUser(userDetails.toModel())).thenThrow(SaveUserFailure());

    final result = await saveUserRepository.saveUser(userDetails);

    expect(result, isA<Left<SaveUserFailure, bool>>());
  });
}
