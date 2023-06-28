import 'package:english_dictionary/core/feature/auth/core/service_locator/auth_service_locator_interface.dart';
import 'package:english_dictionary/core/feature/auth/cubit/auth_cubit.dart';
import 'package:english_dictionary/core/feature/auth/data/datasource/login_datasource.dart';
import 'package:english_dictionary/core/feature/auth/data/datasource/login_datasource_interface.dart';
import 'package:english_dictionary/core/feature/auth/data/repositores/login_repository.dart';
import 'package:english_dictionary/core/feature/auth/domain/repositores/login_repository_interface.dart';
import 'package:english_dictionary/core/feature/auth/domain/usecases/login_usecase.dart';
import 'package:english_dictionary/core/feature/auth/domain/usecases/login_usecase_interface.dart';
import 'package:get_it/get_it.dart';

class AuthServiceLocator implements IAuthServiceLocator {
  AuthServiceLocator();

  @override
  Future<void> setup() async {
    final i = GetIt.instance;

    /*datasources*/
    i.registerLazySingleton<ILoginDatasource>(() => LoginDatasource(i.get()));

    /*repositories*/
    i.registerLazySingleton<ILoginRepository>(() => LoginRepository(i.get()));

    /*usecases*/
    i.registerLazySingleton<ILoginUsecase>(() => LoginUsecase(i.get()));

    /*cubits*/
    i.registerLazySingleton(() => AuthCubit(i.get()));
  }
}
