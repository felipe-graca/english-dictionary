import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/user_details/core/errors/user_details_failure.dart';
import 'package:english_dictionary/core/feature/user_details/data/repositories/save_user/save_user_repository.dart';
import 'package:english_dictionary/core/feature/user_details/domain/entities/user_details_entity.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/save_user/save_user_usecase.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/save_user/save_user_usecase_interface.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'save_user_usecase_test.mocks.dart';

@GenerateMocks([SaveUserRepository])
main() {
  final saveUserRepository = MockSaveUserRepository();

  final ISaveUserUsecase saveUserUsecase = SaveUserUsecase(saveUserRepository);

  final faker = Faker();
  final userDetails = UserDetailsEntity(
    name: faker.person.name(),
    email: faker.internet.email(),
    base64Image: faker.internet.httpUrl(),
    uid: faker.guid.guid(),
  );

  test('Should return true when saveUser is success', () async {
    when(saveUserRepository.saveUser(any)).thenAnswer((_) async => const Right(true));

    final result = await saveUserUsecase(userDetails);

    expect(result, isA<Right<SaveUserFailure, bool>>());
    expect(result, const Right(true));
  });

  test('Should return failure when saveUser is failure', () async {
    when(saveUserRepository.saveUser(any)).thenAnswer((_) async => Left(SaveUserFailure()));

    final result = await saveUserUsecase(userDetails);

    expect(result, isA<Left<SaveUserFailure, bool>>());
    expect(result.fold((failure) => failure, (success) => success), isA<SaveUserFailure>());
  });
}
