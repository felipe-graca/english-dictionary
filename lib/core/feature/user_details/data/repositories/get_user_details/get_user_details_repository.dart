import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/user_details/core/errors/user_details_failure.dart';
import 'package:english_dictionary/core/feature/user_details/data/datasources/get_user_details/get_user_details_datasource_interface.dart';
import 'package:english_dictionary/core/feature/user_details/domain/entities/user_data_entity.dart';
import 'package:english_dictionary/core/feature/user_details/domain/repositories/get_user_details/get_user_details_repository_interface.dart';

class GetUserDetailsRepository implements IGetUserDetailsRepository {
  final IGetUserDetailsDatasource _getLoggedUserDatasource;

  GetUserDetailsRepository(this._getLoggedUserDatasource);

  @override
  Future<Either<GetUserDatailsFailure, UserDataEntity>> getUserDetails() async {
    try {
      final user = await _getLoggedUserDatasource.getUserDetails();
      return Right(user.toEntity());
    } on GetUserDatailsFailure catch (e) {
      return Left(e);
    }
  }
}
