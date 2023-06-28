import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_dictionary/core/feature/auth/core/service_locator/auth_service_locator_interface.dart';
import 'package:english_dictionary/core/services/firebase/firebase_service.dart';
import 'package:english_dictionary/core/services/firebase/firebase_service_interface.dart';
import 'package:english_dictionary/ui/global/bottom_navigator/bottom_navigator_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceLocator {
  ServiceLocator._();
  static Future<void> setup() async {
    final i = GetIt.instance;

    /*singletons packages*/
    i.registerSingleton(await SharedPreferences.getInstance());
    i.registerSingleton(FirebaseFirestore.instance);

    /*cubits*/
    i.registerLazySingleton(() => BottomNavigatorCubit());

    /*services*/
    i.registerLazySingleton<IFirebaseService>(() => FirebaseService());
  }

  static Future<void> initializeAllFeaturesInjections({
    required IAuthServiceLocator authLocator,
  }) async {
    await setup().then(
      (value) async => await Future.wait(
        [
          authLocator.setup(),
        ],
      ),
    );
  }
}
