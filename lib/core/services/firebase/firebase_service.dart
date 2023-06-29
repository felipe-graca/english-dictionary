import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/auth/data/model/user_data_model.dart';
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
      if (googleUser == null) throw FirebaseAuthException(code: 'ERROR_ABORTED_BY_USER');

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
  Future<bool> saveUser(UserDataModel model) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw FirebaseAuthException(code: 'ERROR_ABORTED_BY_USER');

      await _firestore.collection('users').doc(user.uid).set(model.toMap());
      return true;
    } on FirebaseAuthException catch (e) {
      throw SaveUserFailure(message: (e.message ?? '').toString());
    }
  }

  @override
  Future<UserDataModel> getUserDetails() async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw FirebaseAuthException(code: 'ERROR_ABORTED_BY_USER');

      final snapshot = await _firestore.collection('users').doc(user.uid).get();

      if (snapshot.data() == null) throw FirebaseAuthException(code: 'ERROR_ABORTED_BY_USER');

      return UserDataModel.fromMap(snapshot.data()!);
    } on FirebaseAuthException catch (e) {
      throw GetUserDetailsFailure(message: (e.message ?? '').toString());
    }
  }
}
