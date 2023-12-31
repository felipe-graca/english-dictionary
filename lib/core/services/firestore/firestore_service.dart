import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_dictionary/core/errors/firebase_failure.dart';
import 'package:english_dictionary/core/services/auth/auth_service_interface.dart';
import 'package:english_dictionary/core/services/firestore/firestore_service_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService implements IFirestoreService {
  final IAuthService _auth;
  final FirebaseFirestore _firestore;
  FirestoreService(this._auth, this._firestore);

  User get getUserId =>
      _auth.currentAuthUserDetails != null ? _auth.currentAuthUserDetails! : throw FirestoreFailure(message: 'ERROR_ABORTED_BY_USER');

  @override
  Future<List<Map<String, dynamic>>> getWords() async => await _firestore
      .collection('words')
      .get()
      .then((value) => List<Map<String, dynamic>>.from(value.docs.map((e) => e.data())))
      .catchError((e) => throw FirestoreFailure(message: 'ERROR_ABORTED_BY_USER'));

  @override
  Future<bool> saveUser(Map<String, dynamic> map) async => await _firestore
      .collection('users')
      .doc(getUserId.uid)
      .set(map)
      .then((value) => true)
      .catchError((e) => throw FirestoreFailure(message: 'ERROR_ABORTED_BY_USER'));

  @override
  Future<Map<String, dynamic>> getUserDetails() async => await _firestore
      .collection('users')
      .doc(getUserId.uid)
      .get()
      .then((value) => value.data()!)
      .catchError((e) => throw FirestoreFailure(message: 'ERROR_ABORTED_BY_USER'));

  @override
  Future<bool> existsUser() async => await _firestore
      .collection('users')
      .doc(getUserId.uid)
      .get()
      .then((value) => value.exists)
      .catchError((e) => throw FirestoreFailure(message: 'ERROR_ABORTED_BY_USER'));

  @override
  Future<bool> saveFavoriteWord(Map<String, dynamic> map) async => await _firestore
      .collection('users')
      .doc(getUserId.uid)
      .collection('favorites')
      .doc(map['id'])
      .set(map)
      .then((_) => true)
      .catchError((e) => throw FirestoreFailure(message: 'ERROR_ABORTED_BY_USER'));

  @override
  Future<List<Map<String, dynamic>>> getFavoritesWords() async => await _firestore
      .collection('users')
      .doc(getUserId.uid)
      .collection('favorites')
      .get()
      .then((value) => List<Map<String, dynamic>>.from(value.docs.map((e) => e.data())))
      .catchError((e) => throw FirestoreFailure(message: 'ERROR_ABORTED_BY_USER'));

  @override
  Future<bool> removeFavoriteWord(Map<String, dynamic> map) async => await _firestore
      .collection('users')
      .doc(getUserId.uid)
      .collection('favorites')
      .doc(map['id'])
      .delete()
      .then((value) => true)
      .catchError((e) => throw FirestoreFailure(message: 'ERROR_ABORTED_BY_USER'));

  @override
  Future<bool> saveHistoryWord(Map<String, dynamic> map) async => await _firestore
      .collection('users')
      .doc(getUserId.uid)
      .collection('history')
      .doc(map['id'])
      .set({...map, 'date': DateTime.now().millisecondsSinceEpoch})
      .then((value) => true)
      .catchError((e) => throw FirestoreFailure(message: 'ERROR_ABORTED_BY_USER'));

  @override
  Future<List<Map<String, dynamic>>> getHistoryWords() async => await _firestore
      .collection('users')
      .doc(getUserId.uid)
      .collection('history')
      .orderBy('date', descending: true)
      .get()
      .then((value) => List<Map<String, dynamic>>.from(value.docs.map((e) => e.data())));

  @override
  Future<bool> clearHistoryWords() async =>
      await _firestore.collection('users').doc(getUserId.uid).collection('history').get().then((snapshot) async {
        for (final ds in snapshot.docs) {
          await ds.reference.delete();
        }
        return true;
      }).catchError((e) => throw FirestoreFailure(message: 'ERROR_ABORTED_BY_USER'));
}
