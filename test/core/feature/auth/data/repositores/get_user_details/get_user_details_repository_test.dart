import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/auth/data/datasource/get_user_details/get_user_details_datasource.dart.dart';
import 'package:english_dictionary/core/feature/auth/data/repositores/get_user_details/get_user_details_repository.dart';
import 'package:english_dictionary/core/feature/auth/domain/entities/user_data_entity.dart';
import 'package:english_dictionary/core/feature/auth/domain/repositores/get_user_details/get_user_details_repository_interface.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_user_details_repository_test.mocks.dart';

@GenerateMocks([GetUserDetailsDatasource])
void main() {
  final faker = Faker();

  final userDataEntity = UserDataEntity(
    name: faker.person.name(),
    email: faker.internet.email(),
    base64Image: faker.image.toString(),
    uid: faker.guid.guid(),
    history: const [],
  );

  final datasource = MockGetUserDetailsDatasource();
  final IGetUserDetailsRepository repository = GetUserDetailsRepository(datasource);

  group(
    'Get user details repository',
    () {
      test(
        'should return user details',
        () async {
          when(datasource.getUserDetails()).thenAnswer((_) async => userDataEntity.toModel());

          final result = await repository.getUserDetails();

          expect(result, isA<Right<GetUserDetailsFailure, UserDataEntity>>());
        },
      );

      test(
        'should return throw when not found user details',
        () async {
          when(datasource.getUserDetails()).thenThrow(GetUserDetailsFailure());

          final result = await repository.getUserDetails();

          expect(result, isA<Left<GetUserDetailsFailure, UserDataEntity>>());
        },
      );
    },
  );
}
