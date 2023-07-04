// Mocks generated by Mockito 5.4.2 from annotations
// in english_dictionary/test/core/services/firebase/firebase_service_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:english_dictionary/core/services/firebase/firebase_service.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [FirebaseService].
///
/// See the documentation for Mockito's code generation for more information.
class MockFirebaseService extends _i1.Mock implements _i2.FirebaseService {
  MockFirebaseService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<bool> signInWithGoogle() => (super.noSuchMethod(
        Invocation.method(
          #signInWithGoogle,
          [],
        ),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
  @override
  _i3.Future<bool> saveUser(Map<String, dynamic>? map) => (super.noSuchMethod(
        Invocation.method(
          #saveUser,
          [map],
        ),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
  @override
  _i3.Future<Map<String, dynamic>> getUserDetails() => (super.noSuchMethod(
        Invocation.method(
          #getUserDetails,
          [],
        ),
        returnValue:
            _i3.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i3.Future<Map<String, dynamic>>);
  @override
  _i3.Future<bool> existsUser() => (super.noSuchMethod(
        Invocation.method(
          #existsUser,
          [],
        ),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
  @override
  _i3.Future<List<Map<String, dynamic>>> getWords() => (super.noSuchMethod(
        Invocation.method(
          #getWords,
          [],
        ),
        returnValue: _i3.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i3.Future<List<Map<String, dynamic>>>);
  @override
  _i3.Future<Map<String, dynamic>> saveFavoriteWord(
          Map<String, dynamic>? map) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveFavoriteWord,
          [map],
        ),
        returnValue:
            _i3.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i3.Future<Map<String, dynamic>>);
  @override
  _i3.Future<List<Map<String, dynamic>>> getFavoritesWords() =>
      (super.noSuchMethod(
        Invocation.method(
          #getFavoritesWords,
          [],
        ),
        returnValue: _i3.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i3.Future<List<Map<String, dynamic>>>);
  @override
  _i3.Future<bool> removeFavoriteWord(Map<String, dynamic>? map) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeFavoriteWord,
          [map],
        ),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
  @override
  _i3.Future<Map<String, dynamic>> saveHistoryWord(Map<String, dynamic>? map) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveHistoryWord,
          [map],
        ),
        returnValue:
            _i3.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i3.Future<Map<String, dynamic>>);
  @override
  _i3.Future<List<Map<String, dynamic>>> getHistoryWords() =>
      (super.noSuchMethod(
        Invocation.method(
          #getHistoryWords,
          [],
        ),
        returnValue: _i3.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i3.Future<List<Map<String, dynamic>>>);
  @override
  _i3.Future<bool> clearHistoryWords() => (super.noSuchMethod(
        Invocation.method(
          #clearHistoryWords,
          [],
        ),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
}
