import 'package:english_dictionary/core/feature/user_details/core/errors/user_details_failure.dart';
import 'package:english_dictionary/core/feature/user_details/data/datasources/get_user_details/get_user_details_datasource_interface.dart';
import 'package:english_dictionary/core/feature/user_details/domain/entities/user_details_entity.dart';
import 'package:english_dictionary/core/feature/user_details/domain/repositories/get_user_details/get_user_details_repository_interface.dart';

class GetUserDetailsRepository implements IGetUserDetailsRepository {
  final IGetUserDetailsDatasource _datasource;

  GetUserDetailsRepository(this._datasource);

  @override
  Future<(GetUserDatailsFailure?, UserDetailsEntity)> getUserDetails() async {
    try {
      return (null, await _datasource.getUserDetails());
    } on GetUserDatailsFailure catch (e) {
      return (e, UserDetailsEntity.empty());
    }
  }
}
