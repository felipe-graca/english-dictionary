import 'package:english_dictionary/core/feature/favorites/cubit/favorites_cubit.dart';
import 'package:english_dictionary/core/feature/history/cubit/history_cubit.dart';
import 'package:english_dictionary/core/routes/app_router.dart';
import 'package:english_dictionary/core/routes/app_routes.dart';
import 'package:english_dictionary/ui/global/light_components/bottom_navigator/bottom_navigator_bar.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  void initState() {
    Future.wait([
      GetIt.I.get<FavoritesCubit>().getFavoritesWords(),
      GetIt.I.get<HistoryCubit>().getHistoryWords(),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Navigator(
            key: AppRouter.navigatorKey,
            onGenerateRoute: AppRouter.mainGenerateRoute,
            initialRoute: AppRoutes.dictionary,
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigatorBar(),
    );
  }
}
