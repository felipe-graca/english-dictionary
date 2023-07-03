import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_dictionary/core/errors/failure.dart';
import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/services/firebase/firebase_service_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService implements IFirebaseService {
  final _googleSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<bool> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) throw FirebaseFailure(plugin: 'ERROR_ABORTED_BY_USER');

      final GoogleSignInAuthentication googleSignInAuthentication = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      await _auth.signInWithCredential(credential);
      return true;
    } on FirebaseAuthException catch (e) {
      throw LoginFailure(message: (e.message ?? '').toString());
    }
  }

  @override
  Future<bool> saveUser(Map<String, dynamic> map) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw FirebaseFailure(plugin: 'ERROR_ABORTED_BY_USER');

      await _firestore.collection('users').doc(user.uid).set(map);
      return true;
    } on FirebaseFailure {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getUserDetails() async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw FirebaseFailure(plugin: 'ERROR_ABORTED_BY_USER');

      final snapshot = await _firestore.collection('users').doc(user.uid).get();

      if (snapshot.data() == null) throw FirebaseFailure(plugin: 'ERROR_ABORTED_BY_USER');

      return snapshot.data()!;
    } on FirebaseFailure {
      rethrow;
    }
  }

  @override
  Future<bool> existsUser() async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw FirebaseFailure(plugin: 'ERROR_ABORTED_BY_USER');

      final snapshot = await _firestore.collection('users').doc(user.uid).get();

      if (snapshot.exists) return true;
      return false;
    } on FirebaseFailure {
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getWords() async {
    try {
      final snapshot = await _firestore.collection('words').get();
      return List.from(snapshot.docs.map((e) => e.data()));
    } on FirebaseFailure {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> saveFavoriteWord(Map<String, dynamic> map) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw FirebaseFailure(plugin: 'ERROR_ABORTED_BY_USER');

      final snapshot = await _firestore.collection('users').doc(user.uid).get();

      if (snapshot.data() == null) throw FirebaseFailure(plugin: 'ERROR_ABORTED_BY_USER');

      final favorites = snapshot.data()!['favorites'] as List<dynamic>;

      favorites.add(map);

      await _firestore.collection('users').doc(user.uid).update({'favorites': favorites});

      return map;
    } on FirebaseFailure {
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getFavoritesWords() async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw FirebaseFailure(plugin: 'ERROR_ABORTED_BY_USER');

      final snapshot = await _firestore.collection('users').doc(user.uid).get();

      if (snapshot.data() == null) throw FirebaseFailure(plugin: 'ERROR_ABORTED_BY_USER');

      final favorites = snapshot.data()!['favorites'] as List<dynamic>;

      return List.from(favorites.map((e) => e as Map<String, dynamic>));
    } on FirebaseFailure {
      rethrow;
    }
  }

  @override
  Future<bool> removeFavoriteWord(Map<String, dynamic> map) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw FirebaseFailure(plugin: 'ERROR_ABORTED_BY_USER');

      final snapshot = await _firestore.collection('users').doc(user.uid).get();

      if (snapshot.data() == null) throw FirebaseFailure(plugin: 'ERROR_ABORTED_BY_USER');

      final favorites = snapshot.data()!['favorites'] as List<dynamic>;

      favorites.remove(map);

      await _firestore.collection('users').doc(user.uid).update({'favorites': favorites});

      return true;
    } on FirebaseFailure {
      rethrow;
    }
  }
}
