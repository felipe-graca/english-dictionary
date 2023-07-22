import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';

abstract interface class ILoginRepository {
  Future<(LoginFailure?, bool)> login();
}
