import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/user_details/core/errors/user_details_failure.dart';
import 'package:english_dictionary/core/feature/user_details/data/datasources/get_user_details/get_user_details_datasource.dart.dart';
import 'package:english_dictionary/core/feature/user_details/data/repositories/get_user_details/get_user_details_repository.dart';
import 'package:english_dictionary/core/feature/user_details/domain/entities/user_details_entity.dart';
import 'package:english_dictionary/core/feature/user_details/domain/repositories/get_user_details/get_user_details_repository_interface.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_user_details_repository_test.mocks.dart';

@GenerateMocks([GetUserDetailsDatasource])
main() {
  final getUserDetailsDatasource = MockGetUserDetailsDatasource();
  final IGetUserDetailsRepository getUserDetailsRepository = GetUserDetailsRepository(getUserDetailsDatasource);

  final faker = Faker();
  final userDetails = UserDetailsEntity(
    name: faker.person.name(),
    email: faker.internet.email(),
    base64Image: faker.internet.httpUrl(),
    uid: faker.guid.guid(),
  );

  test('Should return entity when getUserDetails is success', () async {
    when(getUserDetailsDatasource.getUserDetails()).thenAnswer((_) async => userDetails.toModel());

    final result = await getUserDetailsRepository.getUserDetails();

    expect(result, isA<Right<GetUserDatailsFailure, UserDetailsEntity>>());
    expect(result, Right(userDetails));
  });

  test('Should return failure when getUserDetails is failure', () async {
    when(getUserDetailsDatasource.getUserDetails()).thenThrow(GetUserDatailsFailure());

    final result = await getUserDetailsRepository.getUserDetails();

    expect(result, isA<Left<GetUserDatailsFailure, UserDetailsEntity>>());
    expect(result, Left<GetUserDatailsFailure, UserDetailsEntity>(GetUserDatailsFailure()));
  });
}
