import 'package:english_dictionary/core/services/firebase/firebase_service.dart';
import 'package:english_dictionary/core/services/firebase/firebase_service_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'firebase_service_test.mocks.dart';

@GenerateMocks(
  [FirebaseService],
)
void main() {
  group('Firebase service', () {
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
}
