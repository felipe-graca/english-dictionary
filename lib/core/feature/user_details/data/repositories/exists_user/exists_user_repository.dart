import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/user_details/data/datasources/exists_user/exists_user_datasource.dart';
import 'package:english_dictionary/core/feature/user_details/domain/repositories/exists_user/exists_user_repository_interface.dart';

class ExistsUserRepository implements IExistsUserRepository {
  final IExistsUserDatasource _datasource;

  ExistsUserRepository(this._datasource);

  @override
  Future<(ExistsUserFailure?, bool)> existsUser() async {
    try {
      return (null, await _datasource.existsUser());
    } on ExistsUserFailure catch (e) {
      return (e, false);
    }
  }
}
