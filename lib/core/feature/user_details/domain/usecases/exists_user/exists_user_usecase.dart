import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/user_details/data/datasources/exists_user/exists_user_datasource.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/exists_user/exists_user_usecase_interface.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';

class ExistsUserUsecase implements IExistsUserUsecase {
  final IExistsUserDatasource _existsUserDatasource;

  ExistsUserUsecase(this._existsUserDatasource);

  @override
  Future<Either<ExistsUserFailuire, bool>> call(NoParams noParams) async {
    try {
      final result = await _existsUserDatasource.existsUser();
      return Right(result);
    } on ExistsUserFailuire catch (e) {
      return Left(e);
    }
  }
}
