import 'dart:async';

import 'package:english_dictionary/core/feature/auth/domain/usecases/login/login_usecase_interface.dart';
import 'package:english_dictionary/core/feature/user_details/cubit/user_details_cubit.dart';
import 'package:english_dictionary/core/services/auth/auth_service_interface.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final ILoginUsecase loginUsecase;
  final IAuthService _authService;

  AuthCubit(this.loginUsecase, this._authService) : super(const AuthState()) {
    Future.delayed(const Duration(milliseconds: 500)).then((_) {
      _onUserChanged();
    });
  }

  bool userDetailLoading = false;

  final isLoggedStream = StreamController<bool>.broadcast();
  late final isLogged = isLoggedStream.stream;

  Future<void> login() async {
    emit(state.copyWith(loading: true));
    await loginUsecase
        .call(noParams)
        .then((value) async => value.$2
            ? await _onUserChanged().catchError((e) => emit(state.copyWith(errorMessage: e.message)))
            : emit(state.copyWith(errorMessage: value.$1?.message ?? "Cancelled")))
        .catchError((e) => emit(state.copyWith(errorMessage: e.message)));
    emit(state.copyWith(loading: false));
  }

  void startListenAuthChanges() => _authService.startListenAuthChanges(() => _onUserChanged());

  void dispose() {
    isLoggedStream.close();
  }

  Future<void> _onUserChanged() async {
    if (userDetailLoading) return;

    userDetailLoading = true;

    try {
      switch (_authService.currentAuthUserDetails) {
        case null:
          emit(const AuthState());
        case != null:
          await GetIt.I
              .get<UserDetailsCubit>()
              .initializeUserDetails()
              .then((_) => _ ? emit(state.copyWith(status: AuthStatus.authenticated)) : null)
              .catchError((_) => throw _);
      }
      isLoggedStream.add(_authService.currentAuthUserDetails != null);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    userDetailLoading = false;
  }

  Future<bool> logout() async {
    try {
      await _authService.signOut();
      emit(const AuthState(
        status: AuthStatus.unauthenticated,
        loading: false,
        errorMessage: '',
      ));
      isLoggedStream.add(false);
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
      token = await _authService.currentAuthUserDetails?.getIdToken(true);
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      token = await _authService.currentAuthUserDetails?.getIdToken(false);
    }
    return token;
  }

  // Future<bool> deleteUser() async {
  //   try {
  //     await _authService_authS.currentUser?.delete();
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
