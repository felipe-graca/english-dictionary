import 'package:english_dictionary/core/feature/user_details/cubit/user_details_cubit.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/exists_user/exists_user_usecase.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/get_user_details/get_user_details_usecase.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/save_user/save_user_usecase.dart';
import 'package:english_dictionary/core/services/storage/storage_service.dart';
import 'package:mockito/annotations.dart';

import 'user_edtails_cubit_test.mocks.dart';

@GenerateMocks([GetUserDetailsUsecase, ExistsUserUsecase, SaveUserUsecase, StorageService])
main() {
  final getUserDetailsUsecase = MockGetUserDetailsUsecase();
  final existsUserUsecase = MockExistsUserUsecase();
  final saveUserUsecase = MockSaveUserUsecase();
  final storageService = MockStorageService();

  final userDetailsCubit = UserDetailsCubit(
    getUserDetailsUsecase,
    existsUserUsecase,
    saveUserUsecase,
    storageService,
  );
}
