import 'package:english_dictionary/core/feature/auth/data/datasource/login_datasource.dart';
import 'package:english_dictionary/core/feature/auth/data/datasource/login_datasource_interface.dart';
import 'package:get_it/get_it.dart';

class AuthLocator {
  AuthLocator._();
  static Future<void> setup() async {
    final i = GetIt.instance;

    /*Datasources*/
    i.registerLazySingleton<ILoginDatasource>(() => LoginDatasource(i.get()));
  }
}
