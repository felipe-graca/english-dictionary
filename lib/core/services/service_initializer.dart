import 'package:english_dictionary/core/feature/dependency_injector_service.dart';
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
    DependencyInjectorService.setup();
  }

  static _initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // analytics = FirebaseAnalytics.instance;
    // firebaseAnalyticsObserver = FirebaseAnalyticsObserver(analytics: analytics);
  }

  // static _initFirebaseMessaging() async {
  //   await FirebaseMessagingService.instance.init();
  // }
}
