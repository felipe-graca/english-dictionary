import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/user_details/core/errors/user_details_failure.dart';
import 'package:english_dictionary/core/feature/user_details/domain/entities/user_data_entity.dart';
import 'package:english_dictionary/core/feature/user_details/domain/repositories/get_user_details/get_user_details_repository_interface.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/get_user_details/get_user_details_usecase_interface.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';

class GetUserDetailsUsecase implements IGetUserDetailsUsecase {
  final IGetUserDetailsRepository _getLoggedUserRepository;

  GetUserDetailsUsecase(this._getLoggedUserRepository);

  @override
  Future<Either<GetUserDatailsFailure, UserDataEntity>> call(NoParams params) async {
    try {
      final user = await _getLoggedUserRepository.getUserDetails();
      return user.fold(
        (failure) => throw failure,
        (success) => Right(success),
      );
    } on GetUserDatailsFailure catch (e) {
      return Left(e);
    }
  }
}
