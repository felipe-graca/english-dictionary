import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:english_dictionary/core/feature/auth/core/services/service_locator/auth_service_locator_interface.dart';
import 'package:english_dictionary/core/feature/favorites/core/services/service_locator/favorites_service_locator_interface.dart';
import 'package:english_dictionary/core/feature/history/core/services/service_locator/history_service_locator_interface.dart';
import 'package:english_dictionary/core/feature/word_signification/core/services/service_locator/word_signification_service_locator_interface.dart';
import 'package:english_dictionary/core/feature/words/core/services/service_locator/words_service_locator_interface.dart';
import 'package:english_dictionary/core/services/firebase/firebase_service.dart';
import 'package:english_dictionary/core/services/firebase/firebase_service_interface.dart';
import 'package:english_dictionary/core/services/http/http_service.dart';
import 'package:english_dictionary/core/services/http/http_service_interface.dart';
import 'package:english_dictionary/core/services/tts/tts_service.dart';
import 'package:english_dictionary/core/services/tts/tts_service_interface.dart';
import 'package:english_dictionary/presenter/dictionary/cubit/dictionary_cubit.dart';
import 'package:english_dictionary/presenter/word/cubit/word_cubit.dart';
import 'package:english_dictionary/ui/global/bottom_navigator/cubit/bottom_navigator_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceLocator {
  ServiceLocator._();
  static Future<void> _setup() async {
    final i = GetIt.instance;

    /*singletons packages*/
    i.registerSingleton(await SharedPreferences.getInstance());
    i.registerSingleton(FirebaseFirestore.instance);

    //dio
    i.registerSingleton(Dio());

    /*cubits*/
    i.registerLazySingleton(() => BottomNavigatorCubit());

    /*services*/
    i.registerLazySingleton<IFirebaseService>(() => FirebaseService());
    i.registerLazySingleton<IHttpService>(() => HttpService(i.get()));
    i.registerLazySingleton<ITtsService>(() => TtsService());
  }

  static Future<void> initializeAllFeaturesInjections({
    required IAuthServiceLocator authLocator,
    required IWordSignificationServiceLocator wordSignificationLocator,
    required IWordsServiceLocator wordsLocator,
    required IFavoritesServiceLocator favoritesLocator,
    required IHistoryServiceLocator historyLocator,
  }) async {
    await _setup()
        .then(
          (value) async => await Future.wait(
            [
              authLocator.setup(),
              historyLocator.setup(),
              wordSignificationLocator.setup(),
              wordsLocator.setup(),
              favoritesLocator.setup(),
            ],
          ),
        )
        .then((value) async => await initializePageCubits());
  }

  static Future<void> initializePageCubits() async {
    final i = GetIt.instance;

    i.registerLazySingleton(() => DictionaryCubit());
    i.registerLazySingleton(() => WordCubit(i.get()));
  }
}
