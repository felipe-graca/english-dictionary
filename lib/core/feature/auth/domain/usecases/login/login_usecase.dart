import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/auth/domain/repositores/login/login_repository_interface.dart';
import 'package:english_dictionary/core/feature/auth/domain/usecases/login/login_usecase_interface.dart';

class LoginUsecase implements ILoginUsecase {
  final ILoginRepository _loginRepository;

  LoginUsecase(this._loginRepository);

  @override
  Future<Either<LoginFailure, bool>> call(noParams) async {
    return await _loginRepository.login();
  }
}
