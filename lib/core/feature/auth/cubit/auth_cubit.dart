import 'dart:async';

import 'package:english_dictionary/core/feature/user_details/domain/entities/user_data_entity.dart';
import 'package:english_dictionary/core/feature/auth/domain/usecases/exists_user/exists_user_usecase_interface.dart';
import 'package:english_dictionary/core/feature/auth/domain/usecases/login/login_usecase_interface.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/get_user_details/get_user_details_usecase_interface.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/save_user/save_user_usecase_interface.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final ILoginUsecase loginUsecase;
  final IGetUserDetailsUsecase getUserDetailsUsecase;
  final IExistsUserUsecase existsUserUsecase;
  final ISaveUserUsecase saveUserUsecase;
  AuthCubit(
    this.loginUsecase,
    this.getUserDetailsUsecase,
    this.existsUserUsecase,
    this.saveUserUsecase,
  ) : super(const AuthState()) {
    Future.delayed(const Duration(milliseconds: 500)).then((_) {
      onUserChanged();
    });
  }

  final firebaseAuth = FirebaseAuth.instance;
  var userDetailLoading = false;
  final isLoggedStream = StreamController<bool>.broadcast();
  late final isLogged = isLoggedStream.stream;

  //login
  Future<void> login() async {
    final result = await loginUsecase.call(noParams);
    return result.fold(
      (failure) => throw failure,
      (success) => state.copyWith(currentUser: currentUser.copyWith()),
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

      final wasUserDetails = await existsUserUsecase.call(noParams);
      wasUserDetails.fold(
        (faiulre) => {},
        (success) async {
          if (success) {
            final userDetails = await getUserDetails();
            emit(state.copyWith(currentUser: userDetails));
          } else {
            final userDetails = await initializeUser();
            emit(state.copyWith(currentUser: userDetails));
          }
          emit(state.copyWith(status: AuthStatus.authenticated));
          isLoggedStream.add(!state.currentUser.isEmpty);
          userDetailLoading = false;
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<UserDataEntity> getUserDetails() async {
    try {
      final userDetails = await getUserDetailsUsecase.call(noParams);
      return userDetails.fold(
        (failure) => throw failure,
        (success) => success,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return const UserDataEntity();
    }
  }

  Future<UserDataEntity> initializeUser() async {
    try {
      final userDataEntity = UserDataEntity(
        uid: firebaseAuth.currentUser!.uid,
        email: firebaseAuth.currentUser!.email ?? '',
        name: firebaseAuth.currentUser!.displayName ?? '',
        base64Image: firebaseAuth.currentUser!.photoURL ?? '',
      );

      final result = await saveUserUsecase.call(userDataEntity);
      result.fold(
        (failure) => throw failure,
        (success) => success,
      );
      return userDataEntity;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return const UserDataEntity();
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

  String? getUid() => currentUser.uid;

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

  UserDataEntity get currentUser => state.currentUser;

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
