import 'package:english_dictionary/core/errors/google_failure.dart';
import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/auth/data/datasource/login/login_datasource_interface.dart';
import 'package:english_dictionary/core/services/firebase/firebase_service_interface.dart';

class LoginDatasource implements ILoginDatasource {
  final IFirebaseService _firebaseService;

  LoginDatasource(this._firebaseService);

  @override
  Future<bool> login() {
    try {
      return _firebaseService.signInWithGoogle();
    } on GoogleSignInFailure catch (_) {
      throw LoginFailure(message: _.code);
    }
  }
}
