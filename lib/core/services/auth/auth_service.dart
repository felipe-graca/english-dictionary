import 'package:english_dictionary/core/errors/firebase_failure.dart';
import 'package:english_dictionary/core/errors/google_failure.dart';
import 'package:english_dictionary/core/services/auth/auth_service_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService implements IAuthService {
  final _googleSignIn = GoogleSignIn();

  final _auth = FirebaseAuth.instance;

  @override
  Future<bool> socialSignIn() async => await _googleSignIn
      .signIn()
      .then((value) async => value != null ? await _authOnFirebase(await value.authentication) : false)
      .catchError((e) => throw GoogleSignInFailure.getGoogleSignInErrorMessage(e.code, e.message));

  Future<bool> _authOnFirebase(GoogleSignInAuthentication googleSignInAuthentication) async => await _auth
      .signInWithCredential(_buildGoogleAuthCredential(googleSignInAuthentication))
      .then((value) => value.user != null)
      .catchError((e) => throw e);

  OAuthCredential _buildGoogleAuthCredential(GoogleSignInAuthentication googleSignInAuthentication) => GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

  @override
  User? get currentAuthUserDetails => _auth.currentUser;

  @override
  Future<bool> signOut() async => await _googleSignIn
      .signOut()
      .then((value) async => await _authSignOut())
      .catchError((_) => throw FirestoreFailure(message: 'ERROR_ABORTED_BY_USER'));

  Future<bool> _authSignOut() async =>
      await _auth.signOut().then((value) => true).catchError((_) => throw FirestoreFailure(message: 'ERROR_ABORTED_BY_USER'));

  @override
  Future<void> startListenAuthChanges(Future<void> Function() event) async => _auth.userChanges().listen((_) async {
        await event();
      });
}
