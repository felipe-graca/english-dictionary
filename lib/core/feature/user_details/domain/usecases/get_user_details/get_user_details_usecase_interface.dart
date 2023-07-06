import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/user_details/core/errors/user_details_failure.dart';
import 'package:english_dictionary/core/feature/user_details/domain/entities/user_data_entity.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';

abstract interface class IGetUserDetailsUsecase extends UseCase<UserDataEntity, NoParams> {
  @override
  Future<Either<GetUserDatailsFailure, UserDataEntity>> call(params);
}
