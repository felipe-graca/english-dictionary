import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/user_details/core/errors/user_details_failure.dart';
import 'package:english_dictionary/core/feature/user_details/domain/entities/user_details_entity.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';

abstract interface class ISaveUserUsecase extends UseCase<bool, UserDetailsEntity> {
  @override
  Future<Either<SaveUserFailure, bool>> call(params);
}
