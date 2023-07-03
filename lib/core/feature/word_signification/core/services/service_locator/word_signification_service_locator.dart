import 'package:english_dictionary/core/feature/word_signification/core/services/rapidapi/rapidapi_service.dart';
import 'package:english_dictionary/core/feature/word_signification/core/services/rapidapi/rapidapi_service_interface.dart';
import 'package:english_dictionary/core/feature/word_signification/core/services/service_locator/word_signification_service_locator_interface.dart';
import 'package:english_dictionary/core/feature/word_signification/cubit/word_signification_cubit.dart';
import 'package:english_dictionary/core/feature/word_signification/data/datasource/get_word_signification/get_word_signification_datasource.dart';
import 'package:english_dictionary/core/feature/word_signification/data/datasource/get_word_signification/get_word_signification_datasource_interface.dart';
import 'package:english_dictionary/core/feature/word_signification/data/repositories/get_word_signification/get_word_signification_repository.dart';
import 'package:english_dictionary/core/feature/word_signification/data/repositories/get_word_signification/get_word_signification_trpository_interface.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/usecases/get_word_signification/get_word_signification_usecase.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/usecases/get_word_signification/get_word_signification_usecase_interface.dart';
import 'package:get_it/get_it.dart';

class WordSignificationServiceLocator implements IWordSignificationServiceLocator {
  @override
  Future<void> setup() async {
    final i = GetIt.instance;

    //services
    i.registerLazySingleton<IRapidapiService>(() => RapidapiService(i.get()));

    /*datasources*/
    i.registerLazySingleton<IGetWordSignificationDatasource>(() => GetWordSignificationDatasource(i.get()));

    /*repositories*/
    i.registerLazySingleton<IGetWordSignificationRepository>(() => GetWordSignificationRepository(i.get()));

    /*usecases*/
    i.registerLazySingleton<IGetWordSignificationUsecase>(() => GetWordSignificationUsecase(i.get()));

    /*cubits*/
    i.registerLazySingleton(() => WordSignificationCubit(i.get()));
  }
}
