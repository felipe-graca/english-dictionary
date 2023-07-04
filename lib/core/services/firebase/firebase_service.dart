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
      throw LoginFailure(message: '');
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
      throw LoginFailure(message: '');
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
      throw LoginFailure(message: '');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getWords() async {
    try {
      final snapshot = await _firestore.collection('words').get();
      return List.from(snapshot.docs.map((e) => e.data()));
    } on FirebaseFailure {
      throw LoginFailure(message: '');
    }
  }

  @override
  Future<Map<String, dynamic>> saveFavoriteWord(Map<String, dynamic> map) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw FirebaseFailure(plugin: 'ERROR_ABORTED_BY_USER');
      }

      final snapshot = await _firestore.collection('users').doc(user.uid).collection('favorites').doc(map['id']).get();

      if (!snapshot.exists) {
        await _firestore.collection('users').doc(user.uid).collection('favorites').doc(map['id']).set(map);
        return map;
      }

      return map;
    } on FirebaseFailure {
      throw FirebaseFailure(plugin: 'ERROR_ABORTED_BY_USER');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getFavoritesWords() async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw FirebaseFailure(plugin: 'ERROR_ABORTED_BY_USER');

      final snapshot = await _firestore.collection('users').doc(user.uid).collection('favorites').get();
      if (snapshot.docs.isEmpty) return [];

      return snapshot.docs.map((e) => e.data()).toList();
    } on FirebaseFailure {
      throw LoginFailure(message: '');
    }
  }

  @override
  Future<bool> removeFavoriteWord(Map<String, dynamic> map) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw FirebaseFailure(plugin: 'ERROR_ABORTED_BY_USER');

      final snapshot = await _firestore.collection('users').doc(user.uid).collection('favorites').doc(map['id']).get();

      if (snapshot.exists) {
        await _firestore.collection('users').doc(user.uid).collection('favorites').doc(map['id']).delete();
        return true;
      }

      return false;
    } on FirebaseFailure {
      throw LoginFailure(message: '');
    }
  }

  //history
  @override
  Future<Map<String, dynamic>> saveHistoryWord(Map<String, dynamic> map) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw FirebaseFailure(plugin: 'ERROR_ABORTED_BY_USER');
      }

      final snapshot = await _firestore.collection('users').doc(user.uid).collection('history').doc(map['id']).get();

      if (!snapshot.exists) {
        await _firestore.collection('users').doc(user.uid).collection('history').doc(map['id']).set(map);
        return map;
      }

      return map;
    } on FirebaseFailure {
      throw FirebaseFailure(plugin: 'ERROR_ABORTED_BY_USER');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getHistoryWords() async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw FirebaseFailure(plugin: 'ERROR_ABORTED_BY_USER');

      final snapshot = await _firestore.collection('users').doc(user.uid).collection('history').get();
      if (snapshot.docs.isEmpty) return [];

      return snapshot.docs.map((e) => e.data()).toList();
    } on FirebaseFailure {
      throw LoginFailure(message: '');
    }
  }

  @override
  Future<bool> clearHistoryWords() async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw FirebaseFailure(plugin: 'ERROR_ABORTED_BY_USER');

      final snapshot = await _firestore.collection('users').doc(user.uid).collection('history').get();

      if (snapshot.docs.isNotEmpty) {
        await _firestore.collection('users').doc(user.uid).collection('history').get().then((snapshot) {
          for (DocumentSnapshot ds in snapshot.docs) {
            ds.reference.delete();
          }
        });
        return true;
      }

      return false;
    } on FirebaseFailure {
      throw LoginFailure(message: '');
    }
  }
}
