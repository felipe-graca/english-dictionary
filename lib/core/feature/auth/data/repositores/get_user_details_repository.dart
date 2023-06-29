import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/auth/data/datasource/get_user_details/get_user_details_datasource_interface.dart';
import 'package:english_dictionary/core/feature/auth/domain/entities/user_data_entity.dart';
import 'package:english_dictionary/core/feature/auth/domain/repositores/get_user_details_repository_interface.dart';

class GetUserDetailsRepository implements IGetUserDetailsRepository {
  final IGetLoggedUserDatasource _getLoggedUserDatasource;

  GetUserDetailsRepository(this._getLoggedUserDatasource);

  @override
  Future<Either<GetUserDetailsFailure, UserDataEntity>> getUserDetails() async {
    try {
      final user = await _getLoggedUserDatasource.getUserDetails();
      return Right(UserDataEntity.fromModel(user));
    } on GetUserDetailsFailure catch (e) {
      return Left(e);
    }
  }
}
