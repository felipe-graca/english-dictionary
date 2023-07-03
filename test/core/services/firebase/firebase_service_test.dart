import 'package:english_dictionary/core/errors/failure.dart';
import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/auth/data/model/user_data_model.dart';
import 'package:english_dictionary/core/feature/words/core/errors/words_failure.dart';
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
      final result = await service.signInWithGoogle();
      expect(result, true);
    });

    test('should return false when not logged user', () async {
      when(service.signInWithGoogle()).thenAnswer((_) async => false);
      final result = await service.signInWithGoogle();
      expect(result, false);
    });
  });

  group('Save user', () {
    test('should return true when saved user', () async {
      when(service.saveUser(userDataModel.toMap())).thenAnswer((_) async => true);
      final result = await service.saveUser(userDataModel.toMap());
      expect(result, true);
    });

    test('should return false when not saved user', () async {
      when(service.saveUser(userDataModel.toMap())).thenAnswer((_) async => false);
      final result = await service.saveUser(userDataModel.toMap());
      expect(result, false);
    });
  });

  group('Get user details', () {
    test('should return user details', () async {
      when(service.getUserDetails()).thenAnswer((_) async => userDataModel.toMap());
      final result = await service.getUserDetails();
      expect(result, userDataModel);
    });

    test('should return null when not found user details', () async {
      when(service.getUserDetails()).thenThrow(GetUserDetailsFailure());
      expect(() => service.getUserDetails(), throwsA(isA<GetUserDetailsFailure>()));
    });
  });

  group(
    'Exists user',
    () {
      test('should return true when exists user', () async {
        when(service.existsUser()).thenAnswer((_) async => true);
        final result = await service.existsUser();
        expect(result, true);
      });

      test('should return false when not exists user', () async {
        when(service.existsUser()).thenAnswer((_) async => false);
        final result = await service.existsUser();
        expect(result, false);
      });
    },
  );

  group(
    'getWords',
    () {
      test('should return words', () async {
        when(service.getWords()).thenAnswer((_) async => <Map<String, dynamic>>[]);
        final result = await service.getWords();
        expect(result, <Map<String, dynamic>>[]);
        expect(result, isA<List<Map<String, dynamic>>>());
      });

      test('should return null when not found words', () async {
        when(service.getWords()).thenThrow(GetWordsFailure());
        expect(() => service.getWords(), throwsA(isA<GetWordsFailure>()));
      });
    },
  );

  group(
    'SaveFavoriteWord',
    () {
      test('Should return Map<String, dynamic> when saved favorite word', () async {
        when(service.saveFavoriteWord(<String, dynamic>{})).thenAnswer((_) async => <String, dynamic>{});
        final result = await service.saveFavoriteWord(<String, dynamic>{});
        expect(result, <String, dynamic>{});
        expect(result, isA<Map<String, dynamic>>());
      });

      test('Should return null when not saved favorite word', () async {
        when(service.saveFavoriteWord(<String, dynamic>{})).thenThrow(FirebaseFailure(plugin: ''));
        expect(() => service.saveFavoriteWord(<String, dynamic>{}), throwsA(isA<FirebaseFailure>()));
      });
    },
  );

  group('GetFavoriteWords', () {
    test('Should return List<Map<String, dynamic>> when get favorite words', () async {
      when(service.getFavoritesWords()).thenAnswer((_) async => <Map<String, dynamic>>[]);
      final result = await service.getFavoritesWords();
      expect(result, <Map<String, dynamic>>[]);
      expect(result, isA<List<Map<String, dynamic>>>());
    });

    test('Should return null when not get favorite words', () async {
      when(service.getFavoritesWords()).thenThrow(FirebaseFailure(plugin: ''));
      expect(() => service.getFavoritesWords(), throwsA(isA<FirebaseFailure>()));
    });
  });

  group('RemoveFavoriteWord', () {
    test('Should return true when removed favorite word', () async {
      when(service.removeFavoriteWord(<String, dynamic>{})).thenAnswer((_) async => true);
      final result = await service.removeFavoriteWord(<String, dynamic>{});
      expect(result, true);
    });

    test('Should return false when not removed favorite word', () async {
      when(service.removeFavoriteWord(<String, dynamic>{})).thenAnswer((_) async => false);
      final result = await service.removeFavoriteWord(<String, dynamic>{});
      expect(result, false);
    });
  });
}
