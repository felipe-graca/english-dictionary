import 'dart:async';

import 'package:english_dictionary/core/feature/user_details/cubit/user_details_cubit.dart';
import 'package:english_dictionary/core/feature/auth/domain/usecases/login/login_usecase_interface.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final ILoginUsecase loginUsecase;

  AuthCubit(this.loginUsecase) : super(const AuthState()) {
    Future.delayed(const Duration(milliseconds: 500)).then((_) {
      onUserChanged();
    });
  }

  final userDetailsCubit = GetIt.I.get<UserDetailsCubit>();

  final firebaseAuth = FirebaseAuth.instance;
  var userDetailLoading = false;
  final isLoggedStream = StreamController<bool>.broadcast();
  late final isLogged = isLoggedStream.stream;

  //login
  Future<void> login() async {
    final result = await loginUsecase.call(noParams);

    return result.fold(
      (failure) => throw failure,
      (success) {
        if (firebaseAuth.currentUser != null) {
          state.copyWith(
            userAuthDetails: () => firebaseAuth.currentUser,
            status: AuthStatus.authenticated,
          );
        }
        emit(state.copyWith(status: AuthStatus.unauthenticated));
        return;
      },
    );
  }

  void startListenAuthChanges() {
    firebaseAuth.userChanges().listen((event) {
      onUserChanged();
    });
  }

  dispose() {
    isLoggedStream.close();
  }

  Future<void> onUserChanged() async {
    if (userDetailLoading) {
      return;
    }

    userDetailLoading = true;

    try {
      if (firebaseAuth.currentUser == null) {
        emit(const AuthState(status: AuthStatus.unauthenticated));

        isLoggedStream.add(false);
        userDetailLoading = false;
        return;
      }

      final initializeUserDetails = await userDetailsCubit.initializeUserDetails();
      if (initializeUserDetails) {
        emit(state.copyWith(status: AuthStatus.authenticated));
        isLoggedStream.add(true);
      }
      userDetailLoading = false;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
    }
  }

  Future<String?> getToken() async {
    late final String? token;
    try {
      token = await firebaseAuth.currentUser?.getIdToken(true);
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      token = await firebaseAuth.currentUser?.getIdToken(false);
    }
    return token;
  }

  User? get currentUser => state.userAuthDetails;

  // Future<bool> deleteUser() async {
  //   try {
  //     await _firebaseAuth.currentUser?.delete();
  //     logout();
  //     return true;
  //   } catch (e, s) {
  //     if (kDebugMode) {
  //       print(e);
  //       print(s);
  //     }
  //     return false;
  //   }
  // }
}
