import 'package:english_dictionary/core/feature/words/core/services/service_locator/words_service_locator_interface.dart';
import 'package:english_dictionary/core/feature/words/cubit/words_cubit.dart';
import 'package:english_dictionary/core/feature/words/data/datasources/get_words/get_words_datasource.dart';
import 'package:english_dictionary/core/feature/words/data/datasources/get_words/get_words_datasource_interface.dart';
import 'package:english_dictionary/core/feature/words/data/repositories/get_words/get_words_repository.dart';
import 'package:english_dictionary/core/feature/words/domain/repositories/get_words/get_words_repository_interface.dart';
import 'package:english_dictionary/core/feature/words/domain/usecases/get_words/get_words_usecase.dart';
import 'package:english_dictionary/core/feature/words/domain/usecases/get_words/get_words_usecase_interface.dart';
import 'package:get_it/get_it.dart';

class WordsServiceLocator implements IWordsServiceLocator {
  WordsServiceLocator();

  @override
  Future<void> setup() async {
    final i = GetIt.instance;

    /*datasources*/
    i.registerLazySingleton<IGetWordsDatasource>(() => GetWordsDatasource(i.get()));

    /*repositories*/
    i.registerLazySingleton<IGetWordsRepository>(() => GetWordsRepository(i.get()));

    /*usecases*/
    i.registerLazySingleton<IGetWordsUsecase>(() => GetWordsUsecase(i.get()));

    /*cubits*/
    i.registerLazySingleton(() => WordsCubit(i.get()));
  }
}
