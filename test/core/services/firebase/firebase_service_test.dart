import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/services/firebase/firebase_service.dart';
import 'package:english_dictionary/core/services/firebase/firebase_service_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../feature/auth/data/model/user_data_model_test.dart';
import 'firebase_service_test.mocks.dart';

@GenerateMocks(
  [FirebaseService],
)
void main() {
  group('Firebase service', () {
    group('Login', () {
      test('should return true when logged user', () async {
        final IFirebaseService service = MockFirebaseService();
        when(service.signInWithGoogle()).thenAnswer((_) async => true);
        final result = await service.signInWithGoogle();
        expect(result, true);
      });

      test('should return false when not logged user', () async {
        final IFirebaseService service = MockFirebaseService();
        when(service.signInWithGoogle()).thenAnswer((_) async => false);
        final result = await service.signInWithGoogle();
        expect(result, false);
      });
    });

    group('Save user', () {
      test('should return true when saved user', () async {
        final IFirebaseService service = MockFirebaseService();
        when(service.saveUser(userDataModel)).thenAnswer((_) async => true);
        final result = await service.saveUser(userDataModel);
        expect(result, true);
      });

      test('should return false when not saved user', () async {
        final IFirebaseService service = MockFirebaseService();

        when(service.saveUser(userDataModel)).thenAnswer((_) async => false);
        final result = await service.saveUser(userDataModel);
        expect(result, false);
      });
    });
  });

  group('Get user details', () {
    test('should return user details', () async {
      final IFirebaseService service = MockFirebaseService();
      when(service.getUserDetails()).thenAnswer((_) async => userDataModel);
      final result = await service.getUserDetails();
      expect(result, userDataModel);
    });

    test('should return null when not found user details', () async {
      final IFirebaseService service = MockFirebaseService();
      when(service.getUserDetails()).thenThrow(GetUserDetailsFailure());
      expect(() => service.getUserDetails(), throwsA(isA<GetUserDetailsFailure>()));
    });
  });
}
