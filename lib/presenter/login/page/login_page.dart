import 'package:english_dictionary/core/feature/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class LoginPgae extends StatefulWidget {
  const LoginPgae({super.key});

  @override
  State<LoginPgae> createState() => _LoginPgaeState();
}

class _LoginPgaeState extends State<LoginPgae> {
  final _authCubit = GetIt.I.get<AuthCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      bloc: _authCubit,
      builder: (context, state) {
        return SizedBox(
          child: Center(
            child: ElevatedButton(
              onPressed: () => _authCubit.login(),
              child: const Text('Login'),
            ),
          ),
        );
      },
    );
  }
}
