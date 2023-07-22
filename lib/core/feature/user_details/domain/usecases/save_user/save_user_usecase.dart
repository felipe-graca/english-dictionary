import 'package:english_dictionary/core/feature/user_details/core/errors/user_details_failure.dart';
import 'package:english_dictionary/core/feature/user_details/domain/entities/user_details_entity.dart';
import 'package:english_dictionary/core/feature/user_details/domain/repositories/save_user/save_user_repository_interface.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/save_user/save_user_usecase_interface.dart';

class SaveUserUsecase implements ISaveUserUsecase {
  final ISaveUserRepository _repository;

  SaveUserUsecase(this._repository);

  @override
  Future<(SaveUserFailure?, bool)> call(UserDetailsEntity params) async => await _repository.saveUser(params);
}
