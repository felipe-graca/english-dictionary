import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/auth/cubit/auth_cubit.dart';
import 'package:english_dictionary/core/feature/auth/domain/usecases/login/login_usecase.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_cubit_test.mocks.dart';

@GenerateMocks([
  LoginUsecase,
  FirebaseAuth,
])
main() {
  final loginUsecase = MockLoginUsecase();
  final authCubit = AuthCubit(loginUsecase);

  group('login()', () {
    test('login() should set AuthStatus.authenticated when login is success', () async {
      when(authCubit.loginUsecase.call(noParams)).thenAnswer((_) async => (null, true));

      await authCubit.login();

      verify(authCubit.emit(const AuthState(status: AuthStatus.authenticated))).called(1);
      verify(authCubit.isLoggedStream.add(true)).called(1);
    });

    test('login() should set AuthStatus.unauthenticated when login is failure', () async {
      when(authCubit.loginUsecase.call(noParams)).thenAnswer((_) async => (LoginFailure(), false));

      await authCubit.login();

      verify(authCubit.emit(const AuthState(status: AuthStatus.unauthenticated))).called(1);
      verify(authCubit.isLoggedStream.add(false)).called(1);
    });
  });
}
