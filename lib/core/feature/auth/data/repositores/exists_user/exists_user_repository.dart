import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/auth/data/datasource/exists_user/exists_user_datasource.dart';
import 'package:english_dictionary/core/feature/auth/domain/repositores/exists_user/exists_user_repository_interface.dart';

class ExistsUserRepository implements IExistsUserRepository {
  final IExistsUserDatasource _existsUserDatasource;

  ExistsUserRepository(this._existsUserDatasource);

  @override
  Future<Either<ExistsUserFailuire, bool>> existsUser() async {
    try {
      final result = await _existsUserDatasource.existsUser();
      return right(result);
    } on ExistsUserFailuire catch (e) {
      return left(e);
    }
  }
}
