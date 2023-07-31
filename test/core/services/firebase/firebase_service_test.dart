import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:get_it/get_it.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:faker/faker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

import 'package:english_dictionary/core/services/auth/auth_service_interface.dart';
import 'package:english_dictionary/core/services/firebase/firestore_service.dart';
import 'package:english_dictionary/core/services/firebase/firestore_service_interface.dart';
import 'package:english_dictionary/core/errors/firebase_failure.dart';
import 'package:english_dictionary/core/feature/favorites/domain/entities/favorite_word_entity.dart';
import 'package:english_dictionary/core/feature/history/domain/entities/history_word_entity.dart';
import 'package:english_dictionary/core/feature/user_details/domain/entities/user_details_entity.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';

class MockAuthService extends Mock implements IAuthService {
  final bool isNullUser;
  final bool changeUserId;
  MockAuthService({this.isNullUser = false, this.changeUserId = false});

  final faker = Faker();

  @override
  User? get currentAuthUserDetails => isNullUser
      ? null
      : MockUser(
          isAnonymous: false,
          uid: changeUserId ? faker.guid.guid() : '92ed9b18-47ad-0bd8-40c1-98e286a8b6f2',
          email: faker.internet.email(),
          displayName: faker.person.name(),
        );
}

void main() {
  final mockFirestoreService = FakeFirebaseFirestore();
  late IAuthService mockAuthService;
  late IFirestoreService firestoreService;

  setUpAll(() {
    mockAuthService = MockAuthService();
    firestoreService = FirestoreService(mockAuthService, mockFirestoreService);
    GetIt.instance.registerSingleton(mockFirestoreService);
  });

  group('Words', () {
    test('should return a list of words', () async {
      final mockCollectionReference = mockFirestoreService.collection('words');

      final words = <WordEntity>[
        const WordEntity(id: '1', word: 'word'),
        const WordEntity(id: '2', word: 'word'),
      ];

      for (final word in words) {
        await mockCollectionReference.doc(word.id).set(word.toModel().toMap());
      }

      final result = await firestoreService.getWords();

      expect(result, isA<List<Map<String, dynamic>>>());
      expect(result.length, 2);
      expect(result[0]['id'], words[0].id);
      expect(result[0]['word'], words[0].word);
      expect(result[1]['id'], words[1].id);
      expect(result[1]['word'], words[1].word);
    });
  });

  group('Favorites', () {
    test('should return a list of favorites words', () async {
      final mockCollectionReference =
          mockFirestoreService.collection('users').doc(mockAuthService.currentAuthUserDetails!.uid).collection('favorites');

      final favoritesWords = <FavoriteWordEntity>[
        const FavoriteWordEntity(id: '1', word: 'word'),
        const FavoriteWordEntity(id: '2', word: 'word'),
      ];

      for (final word in favoritesWords) {
        await mockCollectionReference.doc(word.id).set(word.toModel().toMap());
      }

      final result = await firestoreService.getFavoritesWords();

      expect(result, isA<List<Map<String, dynamic>>>());
      expect(result.length, 2);
      expect(result[0]['id'], favoritesWords[0].id);
      expect(result[0]['word'], favoritesWords[0].word);
      expect(result[1]['id'], favoritesWords[1].id);
      expect(result[1]['word'], favoritesWords[1].word);
    });

    test('should return true if save favorite word', () async {
      mockFirestoreService.collection('users').doc(mockAuthService.currentAuthUserDetails!.uid).collection('favorites');

      const favoriteWord = FavoriteWordEntity(
        id: '1',
        word: 'word',
      );

      final result = await firestoreService.saveFavoriteWord(favoriteWord.toModel().toMap());

      expect(result, isA<bool>());
      expect(result, true);
    });

    test('should return true if delete favorite word', () async {
      final mockCollectionReference =
          mockFirestoreService.collection('users').doc(mockAuthService.currentAuthUserDetails!.uid).collection('favorites');

      const favoriteWord = FavoriteWordEntity(
        id: '1',
        word: 'word',
      );

      await mockCollectionReference.doc(favoriteWord.id).set(favoriteWord.toModel().toMap());

      final result = await firestoreService.removeFavoriteWord(favoriteWord.toModel().toMap());

      expect(result, isA<bool>());
      expect(result, true);
    });
  });

  group('UserDetails', () {
    test('should return a user details', () async {
      final mockCollectionReference = mockFirestoreService.collection('users');

      final userDetails = UserDetailsEntity(
        uid: mockAuthService.currentAuthUserDetails!.uid,
        name: mockAuthService.currentAuthUserDetails!.displayName!,
        email: mockAuthService.currentAuthUserDetails!.email!,
        imagePath: mockAuthService.currentAuthUserDetails!.photoURL!,
      );

      await mockCollectionReference.doc(userDetails.uid).set(userDetails.toModel().toMap());

      final result = await firestoreService.getUserDetails();

      expect(result, isA<Map<String, dynamic>>());
      expect(result['uid'], userDetails.uid);
      expect(result['name'], userDetails.name);
      expect(result['email'], userDetails.email);
      expect(result['imagePath'], userDetails.imagePath);
    });

    test('should return true if user exists', () async {
      final mockCollectionReference = mockFirestoreService.collection('users');

      final userDetails = UserDetailsEntity(
        uid: mockAuthService.currentAuthUserDetails!.uid,
        name: mockAuthService.currentAuthUserDetails!.displayName!,
        email: mockAuthService.currentAuthUserDetails!.email!,
        imagePath: mockAuthService.currentAuthUserDetails!.photoURL!,
      );

      await mockCollectionReference.doc(userDetails.uid).set(userDetails.toModel().toMap());

      final result = await firestoreService.existsUser();

      expect(result, isA<bool>());
      expect(result, true);
    });

    test('should return false if user not exists', () async {
      mockAuthService = MockAuthService(changeUserId: true);
      firestoreService = FirestoreService(mockAuthService, mockFirestoreService);

      final result = await firestoreService.existsUser();

      expect(result, isA<bool>());
      expect(result, false);
    });

    test('should return throw if user is null', () async {
      mockAuthService = MockAuthService(isNullUser: true);
      firestoreService = FirestoreService(mockAuthService, mockFirestoreService);
      expect(() async => await firestoreService.existsUser(), throwsA(isA<FirebaseFailure>()));
    });

    test('should return true if save user', () async {
      mockAuthService = MockAuthService();
      firestoreService = FirestoreService(mockAuthService, mockFirestoreService);

      mockFirestoreService.collection('users');

      final userDetails = UserDetailsEntity(
        uid: mockAuthService.currentAuthUserDetails!.uid,
        name: mockAuthService.currentAuthUserDetails!.displayName!,
        email: mockAuthService.currentAuthUserDetails!.email!,
        imagePath: mockAuthService.currentAuthUserDetails!.photoURL!,
      );

      final result = await firestoreService.saveUser(userDetails.toModel().toMap());

      expect(result, isA<bool>());
      expect(result, true);
    });
  });

  group("History", () {
    test('should return HistoryWords', () async {
      final mockCollectionReference = mockFirestoreService
          .collection('users')
          .doc(mockAuthService.currentAuthUserDetails?.uid ?? '92ed9b18-47ad-0bd8-40c1-98e286a8b6f2')
          .collection('history');

      final historyWords = <HistoryWordEntity>[
        const HistoryWordEntity(id: '1', word: 'word'),
        const HistoryWordEntity(id: '2', word: 'word'),
      ];

      for (final word in historyWords) {
        await mockCollectionReference.doc(word.id).set({...word.toModel().toMap(), 'date': DateTime.now().millisecondsSinceEpoch});
      }

      final result = await firestoreService.getHistoryWords();

      expect(result, isA<List<Map<String, dynamic>>>());
      expect(result.length, 2);
    });

    test('Should return true if clear history words', () async {
      final mockCollectionReference = mockFirestoreService
          .collection('users')
          .doc(mockAuthService.currentAuthUserDetails?.uid ?? '92ed9b18-47ad-0bd8-40c1-98e286a8b6f2')
          .collection('history');

      final historyWords = <HistoryWordEntity>[
        const HistoryWordEntity(id: '1', word: 'word'),
        const HistoryWordEntity(id: '2', word: 'word'),
      ];

      for (final word in historyWords) {
        await mockCollectionReference.doc(word.id).set(word.toModel().toMap());
      }

      final result = await firestoreService.clearHistoryWords();

      expect(result, isA<bool>());
      expect(result, true);
    });

    test('should return true if save history word', () async {
      mockFirestoreService
          .collection('users')
          .doc(mockAuthService.currentAuthUserDetails?.uid ?? '92ed9b18-47ad-0bd8-40c1-98e286a8b6f2')
          .collection('history');

      const historyWord = HistoryWordEntity(
        id: '1',
        word: 'word',
      );

      final result = await firestoreService.saveHistoryWord(historyWord.toModel().toMap());

      expect(result, isA<bool>());
      expect(result, true);
    });
  });
}
