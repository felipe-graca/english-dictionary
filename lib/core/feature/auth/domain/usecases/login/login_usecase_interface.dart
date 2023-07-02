import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';

abstract interface class ILoginUsecase implements UseCase<bool, NoParams> {
  @override
  Future<Either<LoginFailure, bool>> call(noParams);
}
