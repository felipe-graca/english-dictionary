import 'package:english_dictionary/core/errors/google_failure.dart';
import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/auth/data/datasource/login/login_datasource_interface.dart';
import 'package:english_dictionary/core/services/auth/auth_service_interface.dart';

class LoginDatasource implements ILoginDatasource {
  final IAuthService _authService;

  LoginDatasource(this._authService);

  @override
  Future<bool> login() {
    try {
      return _authService.socialSignIn();
    } on GoogleSignInFailure catch (_) {
      throw LoginFailure(message: _.code);
    }
  }
}
