import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/user_details/core/errors/user_details_failure.dart';
import 'package:english_dictionary/core/feature/user_details/data/repositories/get_user_details/get_user_details_repository.dart';
import 'package:english_dictionary/core/feature/user_details/domain/entities/user_details_entity.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/get_user_details/get_user_details_usecase.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/get_user_details/get_user_details_usecase_interface.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_user_details_usecase_test.mocks.dart';

@GenerateMocks([GetUserDetailsRepository])
main() {
  final faker = Faker();

  final userDataEntity = UserDetailsEntity(
    name: faker.person.name(),
    email: faker.internet.email(),
    base64Image: faker.image.toString(),
    uid: faker.guid.guid(),
  );

  final repository = MockGetUserDetailsRepository();
  final IGetUserDetailsUsecase usecase = GetUserDetailsUsecase(repository);

  test(
    'should return user details',
    () async {
      when(repository.getUserDetails()).thenAnswer((_) async => Right(userDataEntity));
      final result = await usecase.call(noParams);
      final folded = result.fold((l) => l, (r) => r);
      expect(folded, userDataEntity);
    },
  );

  test(
    'should return null when not found user details',
    () async {
      when(repository.getUserDetails()).thenAnswer((_) async => Left(GetUserDatailsFailure()));
      final result = await usecase.call(noParams);
      final folded = result.fold((l) => l, (r) => r);
      expect(folded, isA<GetUserDatailsFailure>());
    },
  );
}
