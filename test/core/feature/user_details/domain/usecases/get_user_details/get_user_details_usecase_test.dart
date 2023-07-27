import 'package:english_dictionary/core/feature/user_details/core/errors/user_details_failure.dart';
import 'package:english_dictionary/core/feature/user_details/data/repositories/get_user_details/get_user_details_repository.dart';
import 'package:english_dictionary/core/feature/user_details/domain/entities/user_details_entity.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_user_details_usecase_test.mocks.dart';

@GenerateMocks([GetUserDetailsRepository])
main() {
  final getUserDetailsRepository = MockGetUserDetailsRepository();

  final faker = Faker();

  final userDetails = UserDetailsEntity(
    name: faker.person.name(),
    email: faker.internet.email(),
    imagePath: faker.internet.httpUrl(),
    uid: faker.guid.guid(),
  );

  test('Should return entity when getUserDetails is success', () async {
    when(getUserDetailsRepository.getUserDetails()).thenAnswer((_) async => (null, userDetails));

    final (failure, result) = await getUserDetailsRepository.getUserDetails();

    expect(result, userDetails);
    expect(failure, isNull);

    verify(getUserDetailsRepository.getUserDetails()).called(1);
    verifyNoMoreInteractions(getUserDetailsRepository);
  });

  test('Should return failure when getUserDetails is failure', () async {
    when(getUserDetailsRepository.getUserDetails()).thenAnswer((_) async => (GetUserDatailsFailure(), UserDetailsEntity.empty()));

    final (failure, result) = await getUserDetailsRepository.getUserDetails();

    expect(result, UserDetailsEntity.empty());
    expect(failure, isA<GetUserDatailsFailure>());

    verify(getUserDetailsRepository.getUserDetails()).called(1);
    verifyNoMoreInteractions(getUserDetailsRepository);
  });
}
