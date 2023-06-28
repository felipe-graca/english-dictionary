import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';

abstract class ILoginRepository {
  Future<Either<LoginFailure, bool>> login();
}
