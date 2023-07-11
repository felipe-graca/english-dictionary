import 'package:english_dictionary/core/feature/favorites/core/services/service_locator/favorites_service_locator_interface.dart';
import 'package:english_dictionary/core/feature/favorites/cubit/favorites_cubit.dart';
import 'package:english_dictionary/core/feature/favorites/data/datasources/get_favorites_words/get_favorites_words_datasource.dart';
import 'package:english_dictionary/core/feature/favorites/data/datasources/get_favorites_words/get_favorites_words_datasource_interface.dart';
import 'package:english_dictionary/core/feature/favorites/data/datasources/remove_favorite_word/remove_favorite_word_datasource.dart';
import 'package:english_dictionary/core/feature/favorites/data/datasources/remove_favorite_word/remove_favorite_word_datasource_interface.dart';
import 'package:english_dictionary/core/feature/favorites/data/datasources/save_favorite_word/save_favorite_word_datasource.dart';
import 'package:english_dictionary/core/feature/favorites/data/datasources/save_favorite_word/save_favorite_word_datasource_interface.dart';
import 'package:english_dictionary/core/feature/favorites/data/repositories/get_favorites_words/get_favorites_words_repository.dart';
import 'package:english_dictionary/core/feature/favorites/data/repositories/remove_favorite_word/remove_favorite_word_repository.dart';
import 'package:english_dictionary/core/feature/favorites/data/repositories/save_favorite_word/save_favorite_word_repository.dart';
import 'package:english_dictionary/core/feature/favorites/domain/repositories/get_favorites_words/get_favorites_words_repository_interface.dart';
import 'package:english_dictionary/core/feature/favorites/domain/repositories/remove_favorite_word/remove_favorite_word_repository_interface.dart';
import 'package:english_dictionary/core/feature/favorites/domain/repositories/save_favorite_word/save_favorite_word_interface.dart';
import 'package:english_dictionary/core/feature/favorites/domain/usecases/get_favorites_words/get_favorites_words_usecase.dart';
import 'package:english_dictionary/core/feature/favorites/domain/usecases/get_favorites_words/get_favorites_words_usecase_interface.dart';
import 'package:english_dictionary/core/feature/favorites/domain/usecases/remove_favorite_word/remove_favorite_word_usecase.dart';
import 'package:english_dictionary/core/feature/favorites/domain/usecases/remove_favorite_word/remove_favorite_word_usecase_interface.dart';
import 'package:english_dictionary/core/feature/favorites/domain/usecases/save_favorite_word/save_favorite_word_usecase.dart';
import 'package:english_dictionary/core/feature/favorites/domain/usecases/save_favorite_word/save_favorite_word_usecase_interface.dart';
import 'package:get_it/get_it.dart';

class FavoritesServiceLocator implements IFavoritesServiceLocator {
  FavoritesServiceLocator();

  @override
  Future<void> setup() async {
    final i = GetIt.instance;

    /*datasources*/

    i.registerLazySingleton<ISaveFavoriteWordDatasource>(() => SaveFavoriteWordDatasource(i.get()));
    i.registerLazySingleton<IRemoveFavoriteWordDatasource>(() => RemoveFavoriteWordDatasource(i.get()));
    i.registerLazySingleton<IGetFavoritesWordsDatasource>(() => GetFavoritesWordsDatasource(i.get()));

    /*repositories*/

    i.registerLazySingleton<ISaveFavoriteWordRepository>(() => SaveFavoriteWordRepository(i.get()));
    i.registerLazySingleton<IRemoveFavoriteWordRepository>(() => RemoveFavoriteWordRepository(i.get()));
    i.registerLazySingleton<IGetFavoritesWordsRepository>(() => GetFavoritesWordsRepository(i.get()));

    /*usecases*/

    i.registerLazySingleton<ISaveFavoriteWordUsecase>(() => SaveFavoriteWordUsecase(i.get()));
    i.registerLazySingleton<IRemoveFavoriteWordUsecase>(() => RemoveFavoriteWordUsecase(i.get()));
    i.registerLazySingleton<IGetFavoritesWordsUsecase>(() => GetFavoritesWordsUsecase(i.get()));

    /*cubits*/
    i.registerLazySingleton(() => FavoritesCubit(i.get(), i.get(), i.get()));
  }
}
