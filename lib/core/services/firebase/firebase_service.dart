import 'package:english_dictionary/core/services/firebase/firebase_service_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService implements IFirebaseService {
  final _auth = FirebaseAuth.instance;

  @override
  Future<UserCredential> signInWithGoogle() async {
    final googleUser = await _auth.signInWithPopup(
      GoogleAuthProvider(),
    );
    return googleUser;
  }
}
