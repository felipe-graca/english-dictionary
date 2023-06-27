import 'package:english_dictionary/core/routes/app_router.dart';
import 'package:english_dictionary/ui/global/bottom_navigator/bottom_navigator_bar.dart';
import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Navigator(
        key: AppRouter.navigatorKey,
        onGenerateRoute: AppRouter.mainGenerateRoute,
        initialRoute: '/Dictionary',
      ),
      bottomNavigationBar: const BottomNavigatorBar(),
    );
  }
}
