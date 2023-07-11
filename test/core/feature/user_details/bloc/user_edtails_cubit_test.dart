import 'package:dartz/dartz.dart';
import 'package:english_dictionary/core/feature/user_details/cubit/user_details_cubit.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/exists_user/exists_user_usecase.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/get_user_details/get_user_details_usecase.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/save_user/save_user_usecase.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_edtails_cubit_test.mocks.dart';

@GenerateMocks([
  GetUserDetailsUsecase,
  ExistsUserUsecase,
  SaveUserUsecase,
])
main() {
  final getUserDetailsUsecase = MockGetUserDetailsUsecase();
  final existsUserUsecase = MockExistsUserUsecase();
  final saveUserUsecase = MockSaveUserUsecase();

  final userDetailsCubit = UserDetailsCubit(getUserDetailsUsecase, existsUserUsecase, saveUserUsecase);

  group('initializeUserDetails()', () {
    test('initializeUserDetails() should return true when user exists', () async {
      when(existsUserUsecase.call(noParams)).thenAnswer((_) async => const Right(true));

      final result = await userDetailsCubit.initializeUserDetails();

      expect(result, true);
    });

    test('initializeUserDetails() should return true when user not exists', () async {
      when(existsUserUsecase.call(noParams)).thenAnswer((_) async => const Right(false));
      when(saveUserUsecase.call(any)).thenAnswer((_) async => const Right(true));

      final result = await userDetailsCubit.initializeUserDetails();

      expect(result, true);
    });

    test('initializeUserDetails() should return false when user not exists and saveUserUsecase return false', () async {
      when(existsUserUsecase.call(noParams)).thenAnswer((_) async => const Right(false));
      when(saveUserUsecase.call(any)).thenAnswer((_) async => const Right(false));

      final result = await userDetailsCubit.initializeUserDetails();

      expect(result, false);
    });
  });
}
