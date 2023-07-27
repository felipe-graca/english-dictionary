import 'package:english_dictionary/core/feature/auth/cubit/auth_cubit.dart';
import 'package:english_dictionary/core/routes/app_router.dart';
import 'package:english_dictionary/core/services/initializer/service_initializer.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    FutureBuilder(
      future: InitializerService.initializeServices(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const MyApp();
        }

        return Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: const SizedBox.shrink(),
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
  final authCubit = GetIt.I.get<AuthCubit>();

  @override
  void initState() {
    authCubit.startListenAuthChanges();
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
