import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/user_details/core/errors/user_details_failure.dart';
import 'package:english_dictionary/core/feature/user_details/domain/entities/user_details_entity.dart';
import 'package:english_dictionary/core/feature/user_details/domain/repositories/get_user_details/get_user_details_repository_interface.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/get_user_details/get_user_details_usecase_interface.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';

class GetUserDetailsUsecase implements IGetUserDetailsUsecase {
  final IGetUserDetailsRepository _getLoggedUserRepository;

  GetUserDetailsUsecase(this._getLoggedUserRepository);

  @override
  Future<Either<GetUserDatailsFailure, UserDetailsEntity>> call(NoParams params) async => await _getLoggedUserRepository.getUserDetails();
}
