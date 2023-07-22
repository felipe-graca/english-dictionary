import 'package:english_dictionary/core/feature/user_details/core/errors/user_details_failure.dart';
import 'package:english_dictionary/core/feature/user_details/domain/entities/user_details_entity.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';

abstract interface class IGetUserDetailsUsecase extends UseCase<UserDetailsEntity, NoParams> {
  @override
  Future<(GetUserDatailsFailure?, UserDetailsEntity)> call(params);
}
