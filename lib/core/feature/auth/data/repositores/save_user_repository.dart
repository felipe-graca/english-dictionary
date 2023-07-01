import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/auth/data/datasource/save_user/save_user_datasource_interface.dart';
import 'package:english_dictionary/core/feature/auth/domain/entities/user_data_entity.dart';
import 'package:english_dictionary/core/feature/auth/domain/repositores/save_user_repository_interface.dart';

class SaveUserRepository implements ISaveUserRepository {
  final ISaveUserDatasource _datasource;

  SaveUserRepository(this._datasource);

  @override
  Future<Either<SaveUserFailure, bool>> saveUser(UserDataEntity userDataEntity) async {
    try {
      final result = await _datasource.saveUser(userDataEntity.toModel());
      return Right(result);
    } on SaveUserFailure catch (e) {
      return Left(e);
    }
  }
}