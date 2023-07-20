import 'dart:async';

import 'package:english_dictionary/core/feature/user_details/cubit/user_details_cubit.dart';
import 'package:english_dictionary/core/feature/auth/domain/usecases/login/login_usecase_interface.dart';
import 'package:english_dictionary/core/routes/app_routes.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';
import 'package:english_dictionary/ui/global/light_components/bottom_navigator/cubit/bottom_navigator_cubit.dart';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final ILoginUsecase loginUsecase;

  AuthCubit(this.loginUsecase) : super(const AuthState()) {
    Future.delayed(const Duration(milliseconds: 500)).then((_) {
      onUserChanged();
    });
  }

  final userDetailsCubit = GetIt.I.get<UserDetailsCubit>();
  final bottomNavigatorCubit = GetIt.I.get<BottomNavigatorCubit>();

  final googleSignIn = GoogleSignIn();
  final firebaseAuth = FirebaseAuth.instance;
  var userDetailLoading = false;
  final isLoggedStream = StreamController<bool>.broadcast();
  late final isLogged = isLoggedStream.stream;

  Future<void> login() async {
    emit(state.copyWith(loading: true));
    final (failure, result) = await loginUsecase.call(noParams);

    if (result) {
      if (firebaseAuth.currentUser != null) {
        state.copyWith(
          userAuthDetails: () => firebaseAuth.currentUser,
          status: AuthStatus.authenticated,
          loading: false,
        );
        isLoggedStream.add(true);
      }
      return;
    }
    emit(state.copyWith(errorMessage: failure!.message, loading: false));
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
        emit(const AuthState(
          status: AuthStatus.unauthenticated,
          loading: false,
          userAuthDetails: null,
          errorMessage: '',
        ));

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

  Future<bool> logout() async {
    try {
      await googleSignIn.signOut();
      await firebaseAuth.signOut();

      bottomNavigatorCubit.changePage(AppRoutes.dictionary);

      return true;
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
    }
    return false;
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
