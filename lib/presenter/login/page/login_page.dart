import 'dart:async';

import 'package:english_dictionary/core/feature/auth/cubit/auth_cubit.dart';
import 'package:english_dictionary/core/routes/app_routes.dart';
import 'package:english_dictionary/ui/global/buttons/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPgae extends StatefulWidget {
  const LoginPgae({super.key});

  @override
  State<LoginPgae> createState() => _LoginPgaeState();
}

class _LoginPgaeState extends State<LoginPgae> {
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
      body: BlocBuilder<AuthCubit, AuthState>(
        bloc: _authCubit,
        builder: (context, state) {
          return SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'English Dictionary',
                  style: GoogleFonts.lato(
                    fontSize: 25,
                    color: const Color.fromRGBO(102, 106, 214, 0.59),
                    fontWeight: FontWeight.bold,
                    height: 0.87,
                    letterSpacing: 1.98,
                  ),
                ),
                const SizedBox(height: 20),
                SvgPicture.asset('assets/icons/dictionary.svg', height: 200),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: PrimaryButton(
                    label: 'Login with Google',
                    fullWidth: true,
                    onTap: () {
                      _authCubit.login();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
