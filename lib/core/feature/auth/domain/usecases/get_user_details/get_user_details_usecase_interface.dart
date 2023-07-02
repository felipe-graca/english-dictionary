import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/auth/domain/entities/user_data_entity.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';

abstract interface class IGetUserDetailsUsecase extends UseCase<UserDataEntity, NoParams> {
  @override
  Future<Either<GetUserDetailsFailure, UserDataEntity>> call(params);
}
