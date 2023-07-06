import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/user_details/core/errors/user_details_failure.dart';
import 'package:english_dictionary/core/feature/user_details/domain/entities/user_data_entity.dart';
import 'package:english_dictionary/core/feature/user_details/domain/repositories/save_user/save_user_repository_interface.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/save_user/save_user_usecase_interface.dart';

class SaveUserUsecase implements ISaveUserUsecase {
  final ISaveUserRepository _saveUserRepository;

  SaveUserUsecase(this._saveUserRepository);

  @override
  Future<Either<SaveUserFailure, bool>> call(UserDataEntity params) async {
    return await _saveUserRepository.saveUser(params);
  }
}
