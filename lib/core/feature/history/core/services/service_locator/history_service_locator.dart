import 'package:english_dictionary/core/feature/favorites/data/datasources/save_favorite_word/save_favorite_word_datasource_interface.dart';
import 'package:english_dictionary/core/feature/history/cubit/history_cubit.dart';
import 'package:english_dictionary/core/feature/history/data/datasources/get_history_words/get_history_words_datasource.dart';
import 'package:english_dictionary/core/feature/history/data/datasources/get_history_words/get_history_words_datasource_interface.dart';
import 'package:english_dictionary/core/feature/history/data/datasources/clear_history_words/clear_history_words_datasource.dart';
import 'package:english_dictionary/core/feature/history/data/datasources/clear_history_words/clear_history_words_datasource_interface.dart';
import 'package:english_dictionary/core/feature/history/data/repositories/get_history_words/get_history_words_repository.dart';
import 'package:english_dictionary/core/feature/history/data/repositories/clear_history_word/remove_favorite_word_repository.dart';
import 'package:english_dictionary/core/feature/history/data/repositories/save_history_word/save_history_word_repository.dart';
import 'package:english_dictionary/core/feature/history/domain/repositories/get_history_words/get_history_words_repository_interface.dart';
import 'package:english_dictionary/core/feature/history/domain/repositories/clear_history_words/clear_history_word_repository_interface.dart';
import 'package:english_dictionary/core/feature/history/domain/repositories/save_history_word/save_history_word_interface.dart';
import 'package:english_dictionary/core/feature/history/domain/usecases/get_history_words/get_history_words_usecase.dart';
import 'package:english_dictionary/core/feature/history/domain/usecases/get_history_words/get_history_words_usecase_interface.dart';
import 'package:english_dictionary/core/feature/history/domain/usecases/clear_history_word/clear_history_word_usecase.dart';
import 'package:english_dictionary/core/feature/history/domain/usecases/clear_history_word/clear_history_word_usecase_interface.dart';
import 'package:english_dictionary/core/feature/history/domain/usecases/save_history_word/save_history_word_usecase.dart';
import 'package:english_dictionary/core/feature/history/domain/usecases/save_history_word/save_history_word_usecase_interface.dart';
import 'package:english_dictionary/core/feature/history/core/services/service_locator/history_service_locator_interface.dart';
import 'package:english_dictionary/core/feature/history/data/datasources/save_history_word/save_history_word_datasource.dart';
import 'package:get_it/get_it.dart';

class HistoryServiceLocator implements IHistoryServiceLocator {
  HistoryServiceLocator();

  @override
  Future<void> setup() async {
    final i = GetIt.instance;

    /*datasources*/

    i.registerLazySingleton<ISaveHistoryWordDatasource>(() => SaveHistoryWordDatasource(i.get()));
    i.registerLazySingleton<IClearHistoryWordsDatasource>(() => RemoveHistoryWordsDatasource(i.get()));
    i.registerLazySingleton<IGetHistoryWordsDatasource>(() => GetHistoryWordsDatasource(i.get()));

    /*repositories*/

    i.registerLazySingleton<IHistoryFavoriteWordRepository>(() => SaveHistoryWordRepository(i.get()));
    i.registerLazySingleton<IClearHistoryWordRepository>(() => ClearHistoryWordRepository(i.get()));
    i.registerLazySingleton<IGetHistoryWordsRepository>(() => GetHistoryWordsRepository(i.get()));

    /*usecases*/

    i.registerLazySingleton<ISaveHistoryWordsUsecase>(() => SaveHistoryWordUsecase(i.get()));
    i.registerLazySingleton<IClearHistoryWordsUsecase>(() => RemoveHistoryWordUsecase(i.get()));
    i.registerLazySingleton<IGetHistoryWordsUsecase>(() => GetHistoryWordsUsecase(i.get()));

    /*cubits*/
    i.registerLazySingleton(() => HistoryCubit(i.get(), i.get(), i.get()));
  }
}
