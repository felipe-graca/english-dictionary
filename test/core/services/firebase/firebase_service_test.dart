import 'package:english_dictionary/core/services/firebase/firebase_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([FirebaseService])
void main() {
  group('Firebase service', () {
    test('should return true when logged user', () async {
      final service = FirebaseService();
      final result = await service.signInWithGoogle();
      expect(result, true);
    });

    test('should return false when not logged user', () async {
      final service = FirebaseService();
      final result = await service.signInWithGoogle();
      expect(result, false);
    });
  });
}
