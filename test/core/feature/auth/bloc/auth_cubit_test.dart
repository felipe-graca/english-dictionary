import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/auth/cubit/auth_cubit.dart';
import 'package:english_dictionary/core/feature/auth/domain/usecases/login/login_usecase.dart';
import 'package:english_dictionary/core/feature/auth/domain/usecases/login/login_usecase_interface.dart';
import 'package:english_dictionary/core/feature/user_details/cubit/user_details_cubit.dart';
import 'package:english_dictionary/core/feature/user_details/domain/entities/user_details_entity.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/exists_user/exists_user_usecase.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/exists_user/exists_user_usecase_interface.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/get_user_details/get_user_details_usecase.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/get_user_details/get_user_details_usecase_interface.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/save_user/save_user_usecase.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/save_user/save_user_usecase_interface.dart';
import 'package:english_dictionary/core/services/auth/auth_service_interface.dart';
import 'package:english_dictionary/core/services/storage/storage_service.dart';
import 'package:english_dictionary/core/services/storage/storage_service_interface.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';
import 'package:faker/faker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_cubit_test.mocks.dart';

class MockAuthService extends Mock implements IAuthService {
  final faker = Faker();

  @override
  User? get currentAuthUserDetails => MockUser(
        isAnonymous: false,
        uid: faker.guid.guid(),
        email: faker.internet.email(),
        displayName: faker.person.name(),
      );
}

@GenerateMocks([
  LoginUsecase,
  GetUserDetailsUsecase,
  ExistsUserUsecase,
  SaveUserUsecase,
  StorageService,
])
void main() {
  final ILoginUsecase mockLoginUsecase = MockLoginUsecase();
  final IAuthService mockAuthService = MockAuthService();

  final IGetUserDetailsUsecase mockGetUserDetailsUsecase = MockGetUserDetailsUsecase();
  final IExistsUserUsecase mockExistsUserUsecase = MockExistsUserUsecase();
  final ISaveUserUsecase mockSaveUserUsecase = MockSaveUserUsecase();
  final IStorageService mockStorageService = MockStorageService();

  final authCubit = AuthCubit(mockLoginUsecase, mockAuthService);

  setUpAll(() => {
        GetIt.I.registerSingleton<UserDetailsCubit>(UserDetailsCubit(
          mockGetUserDetailsUsecase,
          mockExistsUserUsecase,
          mockSaveUserUsecase,
          mockStorageService,
          mockAuthService,
        )),
      });

  when(mockExistsUserUsecase.call(noParams)).thenAnswer((_) async => (null, true));
  when(mockGetUserDetailsUsecase.call(noParams)).thenAnswer((_) async => (null, const UserDetailsEntity(name: 'test')));

  test('initial state is correct', () {
    expect(authCubit.state, const AuthState());
  });

  test('login success updates state', () async {
    when(mockLoginUsecase.call(noParams)).thenAnswer((_) async => (null, true));

    await authCubit.login();

    expect(authCubit.state.status, AuthStatus.authenticated);
    expect(authCubit.state.loading, false);
    expect(authCubit.state.errorMessage, '');
  });

  test('login failure updates state with error message', () async {
    when(mockLoginUsecase.call(noParams)).thenAnswer((_) async => (LoginFailure(), false));

    await authCubit.login();

    expect(authCubit.state.status, AuthStatus.unauthenticated);
    expect(authCubit.state.loading, false);
    expect(authCubit.state.errorMessage, LoginFailure().message);
  });

  test('login cancelled updates state with error message', () async {
    when(mockLoginUsecase.call(noParams)).thenAnswer((_) async => (null, false));

    await authCubit.login();

    expect(authCubit.state.status, AuthStatus.unauthenticated);
    expect(authCubit.state.loading, false);
    expect(authCubit.state.errorMessage, 'Cancelled');
  });
}
