import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/auth/data/datasource/login/login_datasource_interface.dart';
import 'package:english_dictionary/core/feature/auth/domain/repositores/login_repository_interface.dart';

class LoginRepository implements ILoginRepository {
  final ILoginDatasource _loginDatasource;

  LoginRepository(this._loginDatasource);

  @override
  Future<Either<LoginFailure, bool>> login() async {
    try {
      final result = await _loginDatasource.login();
      return right(result);
    } on LoginFailure catch (e) {
      return left(e);
    }
  }
}
