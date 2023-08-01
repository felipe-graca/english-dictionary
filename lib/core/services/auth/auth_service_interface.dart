import 'package:firebase_auth/firebase_auth.dart';

abstract interface class IAuthService {
  Future<bool> socialSignIn();
  Future<bool> signOut();
  Future<void> startListenAuthChanges(Future<void> Function() event);

  User? get currentAuthUserDetails;
}
