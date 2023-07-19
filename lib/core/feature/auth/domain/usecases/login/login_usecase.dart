import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/auth/domain/repositores/login/login_repository_interface.dart';
import 'package:english_dictionary/core/feature/auth/domain/usecases/login/login_usecase_interface.dart';

class LoginUsecase implements ILoginUsecase {
  final ILoginRepository _loginRepository;

  LoginUsecase(this._loginRepository);

  @override
  Future<(LoginFailure?, bool)> call(noParams) async {
    try {
      final result = await _loginRepository.login();
      return (null, result.$2);
    } on LoginFailure catch (e) {
      return (e, false);
    }
  }
}
