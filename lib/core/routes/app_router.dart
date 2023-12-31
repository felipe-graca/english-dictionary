import 'package:english_dictionary/core/routes/app_routes.dart';
import 'package:english_dictionary/presenter/base/page/base_page.dart';
import 'package:english_dictionary/presenter/dictionary/page/dictionary_page.dart';
import 'package:english_dictionary/presenter/error/page/error_page.dart';
import 'package:english_dictionary/presenter/favorites/page/favorites_page.dart';
import 'package:english_dictionary/presenter/history/page/history_page.dart';
import 'package:english_dictionary/presenter/login/page/login_page.dart';
import 'package:english_dictionary/presenter/profile/page/profile_page.dart';
import 'package:english_dictionary/presenter/splash/splash_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  AppRouter._();

  //For main
  static final _mainNavigatorKey = GlobalKey<NavigatorState>();
  static BuildContext get mainContext => _mainNavigatorKey.currentState!.context;
  static GlobalKey<NavigatorState> get navigatorKey => _mainNavigatorKey;

  //For auth
  static final _authNavigatorKey = GlobalKey<NavigatorState>();
  static BuildContext get authContext => _authNavigatorKey.currentState!.context;
  static GlobalKey<NavigatorState> get authNavigatorKey => _authNavigatorKey;

  static PageRouteBuilder mainGenerateRoute(RouteSettings routeSettings) {
    // final args = routeSettings.arguments as Map<String, dynamic>?;

    late final Widget page;

    switch (routeSettings.name) {
      case AppRoutes.dictionary:
        page = const DictionaryPage();
        break;
      case AppRoutes.favorites:
        page = const FivoritesPage();
        break;
      case AppRoutes.history:
        page = const HistoryPage();
        break;
      case AppRoutes.profile:
        page = const ProfilePage();
        break;
      default:
        page = const ErrorPage();
    }
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      settings: routeSettings,
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        animation.drive(CurveTween(curve: Curves.easeInOut));
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  static PageRouteBuilder authGenerateRoute(RouteSettings routeSettings) {
    late final Widget page;

    switch (routeSettings.name) {
      case '/':
      case AppRoutes.splash:
        page = const SplashPage();
        break;
      case AppRoutes.login:
        page = const LoginPgae();
        break;
      case AppRoutes.base:
        page = const BasePage();
        break;
      default:
        page = const ErrorPage();
    }
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      settings: routeSettings,
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}
