import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/services/firebase/firebase_service_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService implements IFirebaseService {
  final _googleSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;

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
}
