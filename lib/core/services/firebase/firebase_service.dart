import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_dictionary/core/errors/firebase_failure.dart';
import 'package:english_dictionary/core/errors/google_failure.dart';
import 'package:english_dictionary/core/services/firebase/firebase_service_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService implements IFirebaseService {
  final _googleSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<bool> signInWithGoogle() async => await _googleSignIn
      .signIn()
      .then((value) async => value != null ? await _authOnFirebase(await value.authentication) : false)
      .catchError((e) => throw GoogleSignInFailure.getGoogleSignInErrorMessage(e.code, e.message));

  Future<bool> _authOnFirebase(GoogleSignInAuthentication googleSignInAuthentication) async => await _auth
      .signInWithCredential(_buildGoogleAuthCredential(googleSignInAuthentication))
      .then((value) => value.user != null)
      .catchError((e) => throw e);

  @override
  Future<List<Map<String, dynamic>>> getWords() async => await _firestore
      .collection('words')
      .get()
      .then((value) => List<Map<String, dynamic>>.from(value.docs.map((e) => e.data())))
      .catchError((e) => throw FirebaseFailure(message: 'ERROR_ABORTED_BY_USER'));

  @override
  Future<bool> saveUser(Map<String, dynamic> map) async => _auth.currentUser != null
      ? await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .set(map)
          .then((value) => true)
          .catchError((e) => throw FirebaseFailure(message: 'ERROR_ABORTED_BY_USER'))
      : throw FirebaseFailure(message: 'ERROR_ABORTED_BY_USER');

  @override
  Future<Map<String, dynamic>> getUserDetails() async => _auth.currentUser != null
      ? await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get()
          .then((value) => value.data()!)
          .catchError((e) => throw FirebaseFailure(message: 'ERROR_ABORTED_BY_USER'))
      : throw FirebaseFailure(message: 'ERROR_ABORTED_BY_USER');

  @override
  Future<bool> existsUser() async => _auth.currentUser != null
      ? await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get()
          .then((value) => value.exists)
          .catchError((e) => throw FirebaseFailure(message: 'ERROR_ABORTED_BY_USER'))
      : throw FirebaseFailure(message: 'ERROR_ABORTED_BY_USER');

  @override
  Future<bool> saveFavoriteWord(Map<String, dynamic> map) async => _auth.currentUser != null
      ? await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('favorites')
          .doc(map['id'])
          .set(map)
          .then((_) => true)
          .catchError((e) => throw FirebaseFailure(message: 'ERROR_ABORTED_BY_USER'))
      : throw FirebaseFailure(message: 'ERROR_ABORTED_BY_USER');

  @override
  Future<List<Map<String, dynamic>>> getFavoritesWords() async => _auth.currentUser != null
      ? await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('favorites')
          .get()
          .then((value) => List<Map<String, dynamic>>.from(value.docs.map((e) => e.data())))
          .catchError((e) => throw FirebaseFailure(message: 'ERROR_ABORTED_BY_USER'))
      : throw FirebaseFailure(message: 'ERROR_ABORTED_BY_USER');

  @override
  Future<bool> removeFavoriteWord(Map<String, dynamic> map) async => _auth.currentUser != null
      ? await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('favorites')
          .doc(map['id'])
          .delete()
          .then((value) => true)
          .catchError((e) => throw FirebaseFailure(message: 'ERROR_ABORTED_BY_USER'))
      : throw FirebaseFailure(message: 'ERROR_ABORTED_BY_USER');

  @override
  Future<bool> saveHistoryWord(Map<String, dynamic> map) async => _auth.currentUser != null
      ? await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('history')
          .doc(map['id'])
          .set({...map, 'date': DateTime.now().millisecondsSinceEpoch})
          .then((value) => true)
          .catchError((e) => throw FirebaseFailure(message: 'ERROR_ABORTED_BY_USER'))
      : throw FirebaseFailure(message: 'ERROR_ABORTED_BY_USER');

  @override
  Future<List<Map<String, dynamic>>> getHistoryWords() async => _auth.currentUser != null
      ? await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('history')
          .get()
          .then((value) => List<Map<String, dynamic>>.from(value.docs.map((e) => e.data())))
      : throw FirebaseFailure(message: 'ERROR_ABORTED_BY_USER');

  @override
  Future<bool> clearHistoryWords() async => _auth.currentUser != null
      ? await _firestore.collection('users').doc(_auth.currentUser!.uid).collection('history').get().then((snapshot) async {
          for (final ds in snapshot.docs) {
            await ds.reference.delete();
          }
          return true;
        }).catchError((e) => throw FirebaseFailure(message: 'ERROR_ABORTED_BY_USER'))
      : throw FirebaseFailure(message: 'ERROR_ABORTED_BY_USER');

  OAuthCredential _buildGoogleAuthCredential(GoogleSignInAuthentication googleSignInAuthentication) => GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
}
