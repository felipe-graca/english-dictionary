import 'package:english_dictionary/core/feature/word_signification/core/services/service_locator/word_signification_service_locator_interface.dart';
import 'package:english_dictionary/core/feature/word_signification/cubit/word_signification_cubit.dart';
import 'package:english_dictionary/core/feature/word_signification/data/datasource/get_word_signification/get_word_signification_datasource.dart';
import 'package:english_dictionary/core/feature/word_signification/data/datasource/get_word_signification/get_word_signification_datasource_interface.dart';
import 'package:english_dictionary/core/feature/word_signification/data/repositories/get_word_signification/get_word_signification_repository.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/repositories/get_word_signification/get_word_signification_repository_interface.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/usecases/get_word_signification/get_word_signification_usecase.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/usecases/get_word_signification/get_word_signification_usecase_interface.dart';
import 'package:get_it/get_it.dart';

class WordSignificationServiceLocator implements IWordSignificationServiceLocator {
  @override
  Future<void> setup() async {
    final i = GetIt.instance;

    /*datasources*/
    i.registerLazySingleton<IGetWordSignificationDatasource>(() => GetWordSignificationDatasource(i.get()));

    /*repositories*/
    i.registerLazySingleton<IGetWordSignificationRepository>(() => GetWordSignificationRepository(i.get()));

    /*usecases*/
    i.registerLazySingleton<IGetWordSignificationUsecase>(() => GetWordSignificationUsecase(i.get()));

    /*cubits*/
    i.registerLazySingleton(() => WordSignificationCubit(i.get(), i.get()));
  }
}
