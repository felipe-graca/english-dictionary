import 'package:firebase_auth/firebase_auth.dart';

abstract class IFirebaseService {
  Future<UserCredential> signInWithGoogle();
}
