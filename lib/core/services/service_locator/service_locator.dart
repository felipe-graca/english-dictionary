import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:english_dictionary/core/feature/auth/core/services/service_locator/auth_service_locator_interface.dart';
import 'package:english_dictionary/core/feature/favorites/core/services/service_locator/favorites_service_locator_interface.dart';
import 'package:english_dictionary/core/feature/history/core/services/service_locator/history_service_locator_interface.dart';
import 'package:english_dictionary/core/feature/user_details/core/services/service_locator/user_details_service_locator_interface.dart';
import 'package:english_dictionary/core/feature/word_signification/core/services/service_locator/word_signification_service_locator_interface.dart';
import 'package:english_dictionary/core/feature/words/core/services/service_locator/words_service_locator_interface.dart';
import 'package:english_dictionary/core/services/auth/auth_service.dart';
import 'package:english_dictionary/core/services/auth/auth_service_interface.dart';
import 'package:english_dictionary/core/services/firebase/firestore_service.dart';
import 'package:english_dictionary/core/services/firebase/firestore_service_interface.dart';
import 'package:english_dictionary/core/services/http/http_service.dart';
import 'package:english_dictionary/core/services/http/http_service_interface.dart';
import 'package:english_dictionary/core/services/storage/storage_service.dart';
import 'package:english_dictionary/core/services/storage/storage_service_interface.dart';
import 'package:english_dictionary/core/services/tts/tts_service.dart';
import 'package:english_dictionary/core/services/tts/tts_service_interface.dart';
import 'package:english_dictionary/ui/global/light_components/bottom_navigator/cubit/bottom_navigator_cubit.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceLocator {
  ServiceLocator._();
  static Future<void> _setup() async {
    final i = GetIt.instance;

    /*singletons packages*/
    i.registerSingleton(await SharedPreferences.getInstance());
    i.registerSingleton(FirebaseFirestore.instance);
    i.registerSingleton(FirebaseStorage.instance);

    //dio
    i.registerSingleton(Dio());

    /*cubits*/
    i.registerLazySingleton(() => BottomNavigatorCubit());

    /*services*/
    i.registerLazySingleton<IAuthService>(() => AuthService());
    i.registerLazySingleton<IFirestoreService>(() => FirestoreService(i.get()));
    i.registerLazySingleton<IStorageService>(() => StorageService());
    i.registerLazySingleton<IHttpService>(() => HttpService(i.get()));
    i.registerLazySingleton<ITtsService>(() => TtsService());
  }

  static Future<void> initializeAllFeaturesInjections({
    required IAuthServiceLocator authLocator,
    required IUserDetailsServiceLocator userDetailsServiceLocator,
    required IWordSignificationServiceLocator wordSignificationLocator,
    required IWordsServiceLocator wordsLocator,
    required IFavoritesServiceLocator favoritesLocator,
    required IHistoryServiceLocator historyLocator,
  }) async {
    await _setup().then(
      (value) async => await Future.wait(
        [
          authLocator.setup(),
          historyLocator.setup(),
          wordSignificationLocator.setup(),
          wordsLocator.setup(),
          favoritesLocator.setup(),
          userDetailsServiceLocator.setup(),
        ],
      ),
    );
  }
}
