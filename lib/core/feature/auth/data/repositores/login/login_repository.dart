import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/auth/data/datasource/login/login_datasource_interface.dart';
import 'package:english_dictionary/core/feature/auth/domain/repositores/login/login_repository_interface.dart';

class LoginRepository implements ILoginRepository {
  final ILoginDatasource _loginDatasource;

  LoginRepository(this._loginDatasource);

  @override
  Future<(LoginFailure?, bool)> login() async {
    try {
      final result = await _loginDatasource.login();
      return (null, result);
    } on LoginFailure catch (e) {
      return (e, false);
    }
  }
}
