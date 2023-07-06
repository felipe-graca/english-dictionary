import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/user_details/core/errors/user_details_failure.dart';
import 'package:english_dictionary/core/feature/user_details/domain/entities/user_data_entity.dart';

abstract interface class IGetUserDetailsRepository {
  Future<Either<GetUserDatailsFailure, UserDataEntity>> getUserDetails();
}
