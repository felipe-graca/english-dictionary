import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_dictionary/core/services/firebase/firebase_service.dart';
import 'package:english_dictionary/core/services/firebase/firebase_service_interface.dart';
import 'package:english_dictionary/ui/global/bottom_navigator/bottom_navigator_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DependencyInjectorService {
  DependencyInjectorService._();
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

  //TODO: Remove if this code is not needed

  // static Future<void> initializeAllFeaturesInjections({
  //   required IAddressDependencyInjection addressDependencyInjection,
  //   required IAuthenticationDependencyInjection authenticationDependencyInjection,
  //   required ICartDependencyInjection cartDependencyInjection,
  //   required IFavoritesDependencyInjection favoritesDependencyInjection,
  //   required IHomeDependencyInjection homeDependencyInjection,
  //   required IOrdersDependencyInjection ordersDependencyInjection,
  //   required IPaymentMethodsDependencyInjection paymentMethodsDependencyInjection,
  //   required IProductDependencyInjection productDependencyInjection,
  //   required IProfileDependencyInjection profileDependencyInjection,
  //   required ISettingsDependencyInjection settingsDependencyInjection,
  //   required IStoreDependencyInjection storeDependencyInjection,
  //   required ISearchDependencyInjection searchDependencyInjection,
  //   required IAnimationDependencyInjection animationDependencyInjection,
  // }) async {
  //   await setup().then(
  //     (value) async => await Future.wait(
  //       [
  //         authenticationDependencyInjection.setup(),
  //         addressDependencyInjection.setup(),
  //         cartDependencyInjection.setup(),
  //         favoritesDependencyInjection.setup(),
  //         homeDependencyInjection.setup(),
  //         ordersDependencyInjection.setup(),
  //         paymentMethodsDependencyInjection.setup(),
  //         productDependencyInjection.setup(),
  //         profileDependencyInjection.setup(),
  //         settingsDependencyInjection.setup(),
  //         searchDependencyInjection.setup(),
  //         storeDependencyInjection.setup(),
  //         animationDependencyInjection.setup(),
  //       ],
  //     ),
  //   );
  // }
}
