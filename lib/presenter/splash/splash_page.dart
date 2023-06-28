import 'dart:async';

import 'package:english_dictionary/core/feature/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SvgPicture.asset('assets/icons/dictionary.svg', height: 200, width: 200),
            const SizedBox(height: 20),
            const Text(
              'English Dictionary',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              color: Colors.black,
              strokeWidth: 1,
            ),
          ],
        ),
      ),
    );
  }
}
