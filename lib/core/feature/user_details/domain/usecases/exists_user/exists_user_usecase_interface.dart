import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';

abstract interface class IExistsUserUsecase implements UseCase<bool, NoParams> {
  @override
  Future<(ExistsUserFailure?, bool)> call(noParams);
}
