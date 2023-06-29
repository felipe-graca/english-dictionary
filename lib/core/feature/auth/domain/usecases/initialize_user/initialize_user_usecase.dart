import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/auth/domain/entities/user_data_entity.dart';
import 'package:english_dictionary/core/feature/auth/domain/repositores/get_user_details_repository_interface.dart';
import 'package:english_dictionary/core/feature/auth/domain/repositores/save_user_repository_interface.dart';
import 'package:english_dictionary/core/feature/auth/domain/usecases/initialize_user/initialize_user_usecase_interface.dart';

class InitializeUserUsecase implements IInitializeUserUsecase {
  final ISaveUserRepository _saveUserRepository;
  final IGetUserDetailsRepository _getLoggedUserRepository;

  InitializeUserUsecase(this._saveUserRepository, this._getLoggedUserRepository);

  @override
  Future<Either<InitializeUserFailure, bool>> call(UserDataEntity params) async {
    try {
      final user = await _getLoggedUserRepository.getUserDetails();
      if (user.isLeft()) {
        await _saveUserRepository.saveUser(params);
        return const Right(true);
      }
      return const Right(false);
    } on InitializeUserFailure catch (e) {
      return Left(e);
    }
  }
}
