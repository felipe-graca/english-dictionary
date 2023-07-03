import 'package:english_dictionary/core/feature/auth/core/services/service_locator/auth_service_locator_interface.dart';
import 'package:english_dictionary/core/feature/auth/cubit/auth_cubit.dart';
import 'package:english_dictionary/core/feature/auth/data/datasource/exists_user/exists_user_datasource.dart';
import 'package:english_dictionary/core/feature/auth/data/datasource/exists_user/exists_user_datasource_interface.dart';
import 'package:english_dictionary/core/feature/auth/data/datasource/get_user_details/get_user_details_datasource.dart.dart';
import 'package:english_dictionary/core/feature/auth/data/datasource/get_user_details/get_user_details_datasource_interface.dart';
import 'package:english_dictionary/core/feature/auth/data/datasource/login/login_datasource.dart';
import 'package:english_dictionary/core/feature/auth/data/datasource/login/login_datasource_interface.dart';
import 'package:english_dictionary/core/feature/auth/data/datasource/save_user/save_user_datasource.dart';
import 'package:english_dictionary/core/feature/auth/data/datasource/save_user/save_user_datasource_interface.dart';
import 'package:english_dictionary/core/feature/auth/data/repositores/exists_user/exists_user_repository.dart';
import 'package:english_dictionary/core/feature/auth/data/repositores/get_user_details/get_user_details_repository.dart';
import 'package:english_dictionary/core/feature/auth/data/repositores/login/login_repository.dart';
import 'package:english_dictionary/core/feature/auth/data/repositores/save_user/save_user_repository.dart';
import 'package:english_dictionary/core/feature/auth/domain/repositores/exists_user/exists_user_repository_interface.dart';
import 'package:english_dictionary/core/feature/auth/domain/repositores/get_user_details/get_user_details_repository_interface.dart';
import 'package:english_dictionary/core/feature/auth/domain/repositores/login/login_repository_interface.dart';
import 'package:english_dictionary/core/feature/auth/domain/repositores/save_user/save_user_repository_interface.dart';
import 'package:english_dictionary/core/feature/auth/domain/usecases/exists_user/exists_user_usecase.dart';
import 'package:english_dictionary/core/feature/auth/domain/usecases/exists_user/exists_user_usecase_interface.dart';
import 'package:english_dictionary/core/feature/auth/domain/usecases/get_user_details/get_user_details_usecase.dart';
import 'package:english_dictionary/core/feature/auth/domain/usecases/get_user_details/get_user_details_usecase_interface.dart';
import 'package:english_dictionary/core/feature/auth/domain/usecases/initialize_user/initialize_user_usecase.dart';
import 'package:english_dictionary/core/feature/auth/domain/usecases/initialize_user/initialize_user_usecase_interface.dart';
import 'package:english_dictionary/core/feature/auth/domain/usecases/login/login_usecase.dart';
import 'package:english_dictionary/core/feature/auth/domain/usecases/login/login_usecase_interface.dart';
import 'package:get_it/get_it.dart';

class AuthServiceLocator implements IAuthServiceLocator {
  AuthServiceLocator();

  @override
  Future<void> setup() async {
    final i = GetIt.instance;

    /*datasources*/
    i.registerLazySingleton<ILoginDatasource>(() => LoginDatasource(i.get()));
    i.registerLazySingleton<IGetUserDetailsDatasource>(() => GetUserDetailsDatasource(i.get()));
    i.registerLazySingleton<ISaveUserDatasource>(() => SaveUserDatasource(i.get()));
    i.registerLazySingleton<IExistsUserDatasource>(() => ExistsUserDatasource(i.get()));

    /*repositories*/
    i.registerLazySingleton<ILoginRepository>(() => LoginRepository(i.get()));
    i.registerLazySingleton<IExistsUserRepository>(() => ExistsUserRepository(i.get()));
    i.registerLazySingleton<IGetUserDetailsRepository>(() => GetUserDetailsRepository(i.get()));
    i.registerLazySingleton<ISaveUserRepository>(() => SaveUserRepository(i.get()));

    /*usecases*/
    i.registerLazySingleton<ILoginUsecase>(() => LoginUsecase(i.get()));
    i.registerLazySingleton<IGetUserDetailsUsecase>(() => GetUserDetailsUsecase(i.get()));
    i.registerLazySingleton<IExistsUserUsecase>(() => ExistsUserUsecase(i.get()));
    i.registerLazySingleton<IInitializeUserUsecase>(() => InitializeUserUsecase(i.get(), i.get()));

    /*cubits*/
    i.registerLazySingleton(() => AuthCubit(i.get(), i.get(), i.get(), i.get()));
  }
}
