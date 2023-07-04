import 'package:english_dictionary/core/feature/auth/core/services/service_locator/auth_service_locator.dart';
import 'package:english_dictionary/core/feature/favorites/core/services/service_locator/favorites_service_locator.dart';
import 'package:english_dictionary/core/feature/history/core/services/service_locator/history_service_locator.dart';
import 'package:english_dictionary/core/feature/word_signification/core/services/service_locator/word_signification_service_locator.dart';
import 'package:english_dictionary/core/feature/words/core/services/service_locator/words_service_locator.dart';
import 'package:english_dictionary/core/services/service_locator/service_locator.dart';
import 'package:english_dictionary/core/services/tts/tts_service.dart';
import 'package:english_dictionary/core/services/tts/tts_service_interface.dart';
import 'package:english_dictionary/core/shared/firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

class ServicesInitializer {
  ServicesInitializer._();

  //TODO: Remove all commented code if not needed

  // static late FirebaseAnalytics analytics;
  // static late FirebaseAnalyticsObserver firebaseAnalyticsObserver;

  static Future<void> initializeServices() async {
    await _initFirebase();
    await _setup().then((_) async => await GetIt.I.allReady());
    await _iniializeTts(ttsService: TtsService());
  }

  static Future<void> _setup() async {
    await ServiceLocator.initializeAllFeaturesInjections(
      authLocator: AuthServiceLocator(),
      wordSignificationLocator: WordSignificationServiceLocator(),
      wordsLocator: WordsServiceLocator(),
      favoritesLocator: FavoritesServiceLocator(),
      historyLocator: HistoryServiceLocator(),
    );
  }

  static _initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // analytics = FirebaseAnalytics.instance;
    // firebaseAnalyticsObserver = FirebaseAnalyticsObserver(analytics: analytics);
  }

  static _iniializeTts({
    required ITtsService ttsService,
  }) async {
    await ttsService.setup();
  }
}
