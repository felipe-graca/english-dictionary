import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/auth/domain/entities/user_data_entity.dart';
import 'package:english_dictionary/core/feature/auth/domain/repositores/exists_user_repository_interface.dart';
import 'package:english_dictionary/core/feature/auth/domain/repositores/save_user_repository_interface.dart';
import 'package:english_dictionary/core/feature/auth/domain/usecases/initialize_user/initialize_user_usecase_interface.dart';

class InitializeUserUsecase implements IInitializeUserUsecase {
  final ISaveUserRepository _saveUserRepository;
  final IExistsUserRepository _existsUserRepository;

  InitializeUserUsecase(this._saveUserRepository, this._existsUserRepository);

  @override
  Future<Either<InitializeUserFailure, bool>> call(UserDataEntity params) async {
    try {
      if (await _existsUser()) {
        return const Right(false);
      }
      final result = await _saveUserRepository.saveUser(params);

      return result.fold(
        (failure) => throw InitializeUserFailure(message: failure.message),
        (success) => Right(success),
      );
    } on InitializeUserFailure catch (e) {
      return Left(e);
    }
  }

  Future<bool> _existsUser() async {
    final result = await _existsUserRepository.existsUser();
    return result.fold(
      (failure) => throw InitializeUserFailure(message: failure.message),
      (success) => success,
    );
  }
}
