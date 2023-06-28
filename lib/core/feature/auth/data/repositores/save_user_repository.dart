import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/auth/data/datasource/save_user_data/save_user_data_interface.dart';
import 'package:english_dictionary/core/feature/auth/data/model/user_data_model.dart';
import 'package:english_dictionary/core/feature/auth/domain/entities/user_data_entity.dart';
import 'package:english_dictionary/core/feature/auth/domain/repositores/save_user_repository_interface.dart';

class SaveUserRepository implements ISaveUserRepository {
  final ISaveUserDatasource _datasource;

  SaveUserRepository(this._datasource);

  @override
  Future<Either<SaveUserFailure, bool>> saveUser(UserDataEntity userDataEntity) async {
    try {
      final result = await _datasource.saveUser(UserDataModel.fromEntity(userDataEntity));
      return Right(result);
    } on SaveUserFailure catch (e) {
      return Left(e);
    }
  }
}
