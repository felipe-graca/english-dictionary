import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/auth/domain/entities/user_data_entity.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';

abstract interface class IInitializeUserUsecase extends UseCase<bool, UserDataEntity> {
  @override
  Future<Either<InitializeUserFailure, bool>> call(params);
}
