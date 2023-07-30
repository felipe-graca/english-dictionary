import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_dictionary/core/errors/firebase_failure.dart';
import 'package:english_dictionary/core/services/auth/auth_service_interface.dart';
import 'package:english_dictionary/core/services/firebase/firestore_service_interface.dart';

class FirestoreService implements IFirestoreService {
  final IAuthService _auth;
  FirestoreService(this._auth);

  final _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Map<String, dynamic>>> getWords() async => await _firestore
      .collection('words')
      .get()
      .then((value) => List<Map<String, dynamic>>.from(value.docs.map((e) => e.data())))
      .catchError((e) => throw FirebaseFailure(message: 'ERROR_ABORTED_BY_USER'));

  @override
  Future<bool> saveUser(Map<String, dynamic> map) async => await _firestore
      .collection('users')
      .doc((_auth.currentAuthUserDetails)!.uid)
      .set(map)
      .then((value) => true)
      .catchError((e) => throw FirebaseFailure(message: 'ERROR_ABORTED_BY_USER'));

  @override
  Future<Map<String, dynamic>> getUserDetails() async => await _firestore
      .collection('users')
      .doc((_auth.currentAuthUserDetails)!.uid)
      .get()
      .then((value) => value.data()!)
      .catchError((e) => throw FirebaseFailure(message: 'ERROR_ABORTED_BY_USER'));

  @override
  Future<bool> existsUser() async => await _firestore
      .collection('users')
      .doc((_auth.currentAuthUserDetails)!.uid)
      .get()
      .then((value) => value.exists)
      .catchError((e) => throw FirebaseFailure(message: 'ERROR_ABORTED_BY_USER'));

  @override
  Future<bool> saveFavoriteWord(Map<String, dynamic> map) async => await _firestore
      .collection('users')
      .doc((_auth.currentAuthUserDetails)!.uid)
      .collection('favorites')
      .doc(map['id'])
      .set(map)
      .then((_) => true)
      .catchError((e) => throw FirebaseFailure(message: 'ERROR_ABORTED_BY_USER'));

  @override
  Future<List<Map<String, dynamic>>> getFavoritesWords() async => await _firestore
      .collection('users')
      .doc((_auth.currentAuthUserDetails)!.uid)
      .collection('favorites')
      .get()
      .then((value) => List<Map<String, dynamic>>.from(value.docs.map((e) => e.data())))
      .catchError((e) => throw FirebaseFailure(message: 'ERROR_ABORTED_BY_USER'));

  @override
  Future<bool> removeFavoriteWord(Map<String, dynamic> map) async => await _firestore
      .collection('users')
      .doc((_auth.currentAuthUserDetails)!.uid)
      .collection('favorites')
      .doc(map['id'])
      .delete()
      .then((value) => true)
      .catchError((e) => throw FirebaseFailure(message: 'ERROR_ABORTED_BY_USER'));

  @override
  Future<bool> saveHistoryWord(Map<String, dynamic> map) async => await _firestore
      .collection('users')
      .doc((_auth.currentAuthUserDetails)!.uid)
      .collection('history')
      .doc(map['id'])
      .set({...map, 'date': DateTime.now().millisecondsSinceEpoch})
      .then((value) => true)
      .catchError((e) => throw FirebaseFailure(message: 'ERROR_ABORTED_BY_USER'));

  @override
  Future<List<Map<String, dynamic>>> getHistoryWords() async => await _firestore
      .collection('users')
      .doc((_auth.currentAuthUserDetails)!.uid)
      .collection('history')
      .orderBy('date', descending: true)
      .get()
      .then((value) => List<Map<String, dynamic>>.from(value.docs.map((e) => e.data())));

  @override
  Future<bool> clearHistoryWords() async =>
      await _firestore.collection('users').doc((_auth.currentAuthUserDetails)!.uid).collection('history').get().then((snapshot) async {
        for (final ds in snapshot.docs) {
          await ds.reference.delete();
        }
        return true;
      }).catchError((e) => throw FirebaseFailure(message: 'ERROR_ABORTED_BY_USER'));
}
