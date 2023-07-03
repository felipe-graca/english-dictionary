import 'package:english_dictionary/core/routes/app_router.dart';
import 'package:english_dictionary/core/services/initializer/service_initializer.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    FutureBuilder(
      future: ServicesInitializer.initializeServices(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const MyApp();
        }

        return Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
              strokeWidth: 1,
            ),
          ),
        );
      },
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'English Dictionary',
      debugShowCheckedModeBanner: false,
      navigatorKey: AppRouter.authNavigatorKey,
      onGenerateRoute: AppRouter.authGenerateRoute,
      initialRoute: '/',
    );
  }
}
