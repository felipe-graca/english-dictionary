import 'package:english_dictionary/core/feature/auth/core/service_locator/auth_service_locator.dart';
import 'package:english_dictionary/core/feature/service_locator.dart';
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
  }

  static Future<void> _setup() async {
    ServiceLocator.initializeAllFeaturesInjections(
      authLocator: AuthServiceLocator(),
    );
  }

  static _initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // analytics = FirebaseAnalytics.instance;
    // firebaseAnalyticsObserver = FirebaseAnalyticsObserver(analytics: analytics);
  }
}
