import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/user_details/domain/repositories/exists_user/exists_user_repository_interface.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/exists_user/exists_user_usecase_interface.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';

class ExistsUserUsecase implements IExistsUserUsecase {
  final IExistsUserRepository _datasource;

  ExistsUserUsecase(this._datasource);

  @override
  Future<(ExistsUserFailure?, bool)> call(NoParams noParams) async => await _datasource.existsUser();
}
