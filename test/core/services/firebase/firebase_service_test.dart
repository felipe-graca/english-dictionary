import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/auth/data/model/user_data_model.dart';
import 'package:english_dictionary/core/services/firebase/firebase_service.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'firebase_service_test.mocks.dart';

@GenerateMocks([FirebaseService])
void main() {
  final faker = Faker();

  final userDataModel = UserDataModel(
    name: faker.person.name(),
    email: faker.internet.email(),
    base64Image: faker.image.toString(),
    uid: faker.guid.guid(),
    history: const [],
  );

  final service = MockFirebaseService();

  group('Login', () {
    test('should return true when logged user', () async {
      when(service.signInWithGoogle()).thenAnswer((_) async => true);
      expect(() async => await service.signInWithGoogle(), true);
    });

    test('should return false when not logged user', () async {
      when(service.signInWithGoogle()).thenAnswer((_) async => false);
      expect(() async => await service.signInWithGoogle(), false);
    });
  });

  group('Save user', () {
    test('should return true when saved user', () async {
      when(service.saveUser(userDataModel)).thenAnswer((_) async => true);
      expect(() async => await service.saveUser(userDataModel), true);
    });

    test('should return false when not saved user', () async {
      when(service.saveUser(userDataModel)).thenAnswer((_) async => false);
      expect(() async => await service.saveUser(userDataModel), false);
    });
  });

  group('Get user details', () {
    test('should return user details', () async {
      when(service.getUserDetails()).thenAnswer((_) async => userDataModel);
      expect(() async => await service.getUserDetails(), userDataModel);
    });

    test('should return null when not found user details', () async {
      when(service.getUserDetails()).thenThrow(GetUserDetailsFailure());
      expect(() async => await service.getUserDetails(), throwsA(isA<GetUserDetailsFailure>()));
    });
  });
}
