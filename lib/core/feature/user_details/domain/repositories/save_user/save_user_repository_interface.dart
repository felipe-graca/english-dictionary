import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/user_details/core/errors/user_details_failure.dart';
import 'package:english_dictionary/core/feature/user_details/domain/entities/user_details_entity.dart';

abstract interface class ISaveUserRepository {
  Future<Either<SaveUserFailure, bool>> saveUser(UserDetailsEntity userDataEntity);
}
