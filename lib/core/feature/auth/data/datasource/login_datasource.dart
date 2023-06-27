import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/auth/data/datasource/login_datasource_interface.dart';
import 'package:english_dictionary/core/services/firebase/firebase_service_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginDatasource implements ILoginDatasource {
  final IFirebaseService _firebaseService;

  LoginDatasource(this._firebaseService);

  @override
  Future<UserCredential> signInWithGoogle() {
    try {
      return _firebaseService.signInWithGoogle();
    } on FirebaseAuthException {
      throw LoginFailure();
    }
  }
}
