import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/auth/domain/entities/user_data_entity.dart';

abstract class ISaveUserRepository {
  Future<Either<SaveUserFailure, bool>> saveUser(UserDataEntity userDataEntity);
}
