import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/auth/data/repositores/exists_user/exists_user_repository.dart';
import 'package:english_dictionary/core/feature/user_details/core/errors/user_details_failure.dart';
import 'package:english_dictionary/core/feature/user_details/data/repositories/save_user/save_user_repository.dart';
import 'package:english_dictionary/core/feature/user_details/domain/entities/user_data_entity.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/save_user/save_user_usecase.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/save_user/save_user_usecase_interface.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'save_user_usecase_test.mocks.dart';

@GenerateMocks([SaveUserRepository])
@GenerateMocks([ExistsUserRepository])
main() {
  final faker = Faker();

  final userDataEntity = UserDataEntity(
    name: faker.person.name(),
    email: faker.internet.email(),
    base64Image: faker.image.toString(),
    uid: faker.guid.guid(),
  );

  final saveUserRepository = MockSaveUserRepository();
  final getUserDetailsRepository = MockExistsUserRepository();

  final ISaveUserUsecase usecase = SaveUserUsecase(saveUserRepository);

  group(
    'success results',
    () {
      test(
        'should return true when saved user',
        () async {
          when(saveUserRepository.saveUser(userDataEntity)).thenAnswer((_) async => const Right(true));
          when(getUserDetailsRepository.existsUser()).thenAnswer((_) async => const Right(false));

          final result = await usecase.call(userDataEntity);
          final folded = result.fold((failure) => failure, (success) => success);

          expect(folded, true);
        },
      );
    },
  );

  group('failure results', () {
    test(
      'Should return false with exists user',
      () async {
        when(saveUserRepository.saveUser(userDataEntity)).thenAnswer((_) async => const Right(false));
        when(getUserDetailsRepository.existsUser()).thenAnswer((_) async => const Right(true));

        final result = await usecase.call(userDataEntity);

        expect(result, const Right(false));
      },
    );

    test(
      'Should return false when not saved user',
      () async {
        when(saveUserRepository.saveUser(userDataEntity)).thenAnswer((_) async => const Right(false));
        when(getUserDetailsRepository.existsUser()).thenAnswer((_) async => const Right(false));

        final result = await usecase.call(userDataEntity);
        final folded = result.fold((failure) => failure, (success) => success);

        expect(folded, false);
      },
    );

    test(
      'Shold return throw when save user',
      () async {
        when(saveUserRepository.saveUser(userDataEntity)).thenAnswer((_) async => Left(SaveUserFailure()));
        when(getUserDetailsRepository.existsUser()).thenAnswer((_) async => const Right(false));

        final result = await usecase.call(userDataEntity);
        final folded = result.fold((failure) => failure, (success) => success);

        expect(folded, isA<SaveUserFailure>());
      },
    );

    test(
      'Should return throw when exists user',
      () async {
        when(saveUserRepository.saveUser(userDataEntity)).thenAnswer((_) async => const Right(false));
        when(getUserDetailsRepository.existsUser()).thenAnswer((_) async => Left(ExistsUserFailuire()));

        final result = await usecase.call(userDataEntity);
        final folded = result.fold((failure) => failure, (success) => success);

        expect(folded, isA<SaveUserFailure>());
      },
    );
  });
}
