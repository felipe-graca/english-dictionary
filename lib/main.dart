import 'package:english_dictionary/core/services/service_initializer.dart';
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

        //TODO: Make a loading screen
        return Container();
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
      home: Container(),
    );
  }
}
