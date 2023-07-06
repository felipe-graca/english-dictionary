import 'package:english_dictionary/core/feature/user_details/core/services/service_locator/user_details_service_locator_interface.dart';
import 'package:english_dictionary/core/feature/user_details/data/datasources/get_user_details/get_user_details_datasource.dart.dart';
import 'package:english_dictionary/core/feature/user_details/data/datasources/get_user_details/get_user_details_datasource_interface.dart';
import 'package:english_dictionary/core/feature/user_details/data/datasources/save_user/save_user_datasource.dart';
import 'package:english_dictionary/core/feature/user_details/data/datasources/save_user/save_user_datasource_interface.dart';
import 'package:english_dictionary/core/feature/user_details/data/repositories/get_user_details/get_user_details_repository.dart';
import 'package:english_dictionary/core/feature/user_details/data/repositories/save_user/save_user_repository.dart';
import 'package:english_dictionary/core/feature/user_details/domain/repositories/get_user_details/get_user_details_repository_interface.dart';
import 'package:english_dictionary/core/feature/user_details/domain/repositories/save_user/save_user_repository_interface.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/get_user_details/get_user_details_usecase.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/get_user_details/get_user_details_usecase_interface.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/save_user/save_user_usecase.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/save_user/save_user_usecase_interface.dart';
import 'package:get_it/get_it.dart';

class UserDetailsServiceLocator implements IUserDetailsServiceLocator {
  UserDetailsServiceLocator();

  @override
  Future<void> setup() async {
    final i = GetIt.instance;

    /*datasources*/

    i.registerLazySingleton<IGetUserDetailsDatasource>(() => GetUserDetailsDatasource(i.get()));
    i.registerLazySingleton<ISaveUserDatasource>(() => SaveUserDatasource(i.get()));

    /*repositories*/

    i.registerLazySingleton<IGetUserDetailsRepository>(() => GetUserDetailsRepository(i.get()));
    i.registerLazySingleton<ISaveUserRepository>(() => SaveUserRepository(i.get()));

    /*usecases*/

    i.registerLazySingleton<IGetUserDetailsUsecase>(() => GetUserDetailsUsecase(i.get()));
    i.registerLazySingleton<ISaveUserUsecase>(() => SaveUserUsecase(i.get()));

    /*cubits*/
    // i.registerLazySingleton(() => UserDetailsCubit(i.get(), i.get(), i.get(), i.get()));
  }
}
