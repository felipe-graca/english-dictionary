import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/auth/cubit/auth_cubit.dart';
import 'package:english_dictionary/core/feature/auth/domain/entities/user_data_entity.dart';
import 'package:english_dictionary/core/feature/auth/domain/usecases/exists_user/exists_user_usecase.dart';
import 'package:english_dictionary/core/feature/auth/domain/usecases/get_user_details/get_user_details_usecase.dart';
import 'package:english_dictionary/core/feature/auth/domain/usecases/initialize_user/initialize_user_usecase.dart';
import 'package:english_dictionary/core/feature/auth/domain/usecases/login/login_usecase.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';
import 'package:faker/faker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_cubit_test.mocks.dart';

@GenerateMocks([
  LoginUsecase,
  FirebaseAuth,
  ExistsUserUsecase,
  InitializeUserUsecase,
  GetUserDetailsUsecase,
])
main() {
  final loginUsecase = MockLoginUsecase();
  final getUserDetailsUsecase = MockGetUserDetailsUsecase();
  final existsUserUsecase = MockExistsUserUsecase();
  final initializeUserUsecase = MockInitializeUserUsecase();

  final authCubit = AuthCubit(
    loginUsecase,
    getUserDetailsUsecase,
    existsUserUsecase,
    initializeUserUsecase,
  );

  final faker = Faker();

  final userDataEntity = UserDataEntity(
    email: faker.internet.email(),
    name: faker.person.name(),
    base64Image: faker.image.image(),
    uid: faker.guid.guid(),
    history: const [],
  );

  group('onUserChanged()', () {
    test('_onUserChanged() should set AuthStatus.unauthenticated when currentUser is null', () async {
      when(authCubit.existsUserUsecase.call(noParams)).thenAnswer((_) async => const Right(false));

      await authCubit.onUserChanged();

      verify(authCubit.emit(const AuthState(status: AuthStatus.unauthenticated))).called(1);
      verify(authCubit.isLoggedStream.add(false)).called(1);
    });

    test('_onUserChanged() should set AuthStatus.authenticated when currentUser is not null', () async {
      when(authCubit.existsUserUsecase.call(noParams)).thenAnswer((_) async => const Right(true));
      when(authCubit.getUserDetailsUsecase.call(noParams)).thenAnswer((_) async => Right(userDataEntity));

      await authCubit.onUserChanged();

      verify(authCubit.emit(const AuthState(status: AuthStatus.authenticated))).called(1);
      verify(authCubit.isLoggedStream.add(true)).called(1);
    });
  });

  group('login()', () {
    test('login() should set AuthStatus.authenticated when login is success', () async {
      when(authCubit.loginUsecase.call(noParams)).thenAnswer((_) async => const Right(true));

      await authCubit.login();

      verify(authCubit.emit(const AuthState(status: AuthStatus.authenticated))).called(1);
      verify(authCubit.isLoggedStream.add(true)).called(1);
    });

    test('login() should set AuthStatus.unauthenticated when login is failure', () async {
      when(authCubit.loginUsecase.call(noParams)).thenAnswer((_) async => Left(LoginFailure()));

      await authCubit.login();

      verify(authCubit.emit(const AuthState(status: AuthStatus.unauthenticated))).called(1);
      verify(authCubit.isLoggedStream.add(false)).called(1);
    });
  });

  group('initializeUser()', () {
    test('initializeUser() Shold return true when initializeUser is success', () async {
      when(authCubit.initializeUserUsecase.call(userDataEntity)).thenAnswer((_) async => const Right(true));

      final result = await authCubit.initializeUser();

      expect(result, const Right(true));
    });

    test('initializeUser() Shold return throw when initializeUser is failure', () async {
      when(authCubit.initializeUserUsecase.call(userDataEntity)).thenAnswer((_) async => Left(InitializeUserFailure()));

      final result = await authCubit.initializeUser();

      expect(result, isA<Left<InitializeUserFailure, bool>>());
    });
  });

  group('getuserDetails()', () {
    test('getUserDetails() Shold return UserDataEntity when getUserDetails is success', () async {
      when(authCubit.getUserDetailsUsecase.call(noParams)).thenAnswer((_) async => Right(userDataEntity));

      final result = await authCubit.getUserDetails();

      expect(result, Right(userDataEntity));
    });

    test('getUserDetails() Shold return throw when getUserDetails is failure', () async {
      when(authCubit.getUserDetailsUsecase.call(noParams)).thenAnswer((_) async => Left(GetUserDetailsFailure()));

      final result = await authCubit.getUserDetails();

      expect(result, isA<Left<GetUserDetailsFailure, UserDataEntity>>());
    });
  });
}
