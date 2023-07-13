import 'dart:async';

import 'package:english_dictionary/core/feature/auth/cubit/auth_cubit.dart';
import 'package:english_dictionary/ui/shared/custom_lottie_build.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../core/routes/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _authCubit = GetIt.I.get<AuthCubit>();

  StreamSubscription<bool>? authSubscription;

  @override
  void initState() {
    authSubscription = _authCubit.isLogged.listen((isLogged) {
      handleNavigation(isLogged);
      authSubscription?.cancel();
    });
    super.initState();
  }

  void handleNavigation(bool isLogged) {
    Future.delayed(const Duration(seconds: 1)).then((_) async {
      if (!mounted) {
        return;
      }
      if (isLogged) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.base);
      } else {
        Navigator.of(context).pushReplacementNamed(AppRoutes.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'English Dictionary',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 200),
            Hero(
              tag: 'loading',
              child: SizedBox(
                width: 200,
                height: 200,
                child: CustomLottieBuilder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
