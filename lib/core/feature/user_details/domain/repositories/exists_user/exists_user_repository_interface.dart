import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';

abstract interface class IExistsUserRepository {
  Future<Either<ExistsUserFailuire, bool>> existsUser();
}