import 'package:english_dictionary/core/feature/user_details/core/errors/user_details_failure.dart';
import 'package:english_dictionary/core/feature/user_details/data/datasources/save_user/save_user_datasource_interface.dart';
import 'package:english_dictionary/core/feature/user_details/domain/entities/user_details_entity.dart';
import 'package:english_dictionary/core/feature/user_details/domain/repositories/save_user/save_user_repository_interface.dart';

class SaveUserRepository implements ISaveUserRepository {
  final ISaveUserDatasource _datasource;

  SaveUserRepository(this._datasource);

  @override
  Future<(SaveUserFailure?, bool)> saveUser(UserDetailsEntity userDataEntity) async {
    try {
      return (null, await _datasource.saveUser(userDataEntity.toModel()));
    } on SaveUserFailure catch (e) {
      return (e, false);
    }
  }
}
