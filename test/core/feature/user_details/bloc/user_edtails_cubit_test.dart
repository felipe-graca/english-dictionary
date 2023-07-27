import 'package:english_dictionary/core/feature/user_details/domain/usecases/exists_user/exists_user_usecase.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/get_user_details/get_user_details_usecase.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/save_user/save_user_usecase.dart';
import 'package:english_dictionary/core/services/storage/storage_service.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([GetUserDetailsUsecase, ExistsUserUsecase, SaveUserUsecase, StorageService])
main() {}
