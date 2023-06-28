import 'dart:async';

import 'package:english_dictionary/core/feature/auth/domain/usecases/login_usecase_interface.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final ILoginUsecase _loginUsecase;

  AuthCubit(this._loginUsecase) : super(const AuthState()) {
    Future.delayed(const Duration(milliseconds: 500)).then((_) {
      _onUserChanged();
    });
  }

  final _firebaseAuth = FirebaseAuth.instance;
  var userDetailLoading = false;
  final _isLoggedStream = StreamController<bool>.broadcast();
  late final isLogged = _isLoggedStream.stream;

  //login
  Future<void> login() async {
    final result = await _loginUsecase.call(noParams);
    return result.fold(
      (failure) => throw failure,
      (success) => state.copyWith(currentUser: _firebaseAuth.currentUser),
    );
  }

  void startListenAuthChanges() {
    _firebaseAuth.userChanges().listen((event) {
      _onUserChanged();
    });
  }

  dispose() {
    _isLoggedStream.close();
  }

  Future<void> _onUserChanged() async {
    if (userDetailLoading) {
      return;
    }

    userDetailLoading = true;

    try {
      if (_firebaseAuth.currentUser == null) {
        emit(const AuthState(status: AuthStatus.unauthenticated));

        _isLoggedStream.add(false);
        userDetailLoading = false;
        return;
      }

      emit(AuthState(status: AuthStatus.authenticated, currentUser: _firebaseAuth.currentUser));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    userDetailLoading = false;
    _isLoggedStream.add(state.currentUser != null);
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
    }
  }

  String? getUid() => currentUser!.uid;

  Future<String?> getToken() async {
    late final String? token;
    try {
      token = await _firebaseAuth.currentUser?.getIdToken(true);
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      token = await _firebaseAuth.currentUser?.getIdToken(false);
    }
    return token;
  }

  User? get currentUser => state.currentUser;

  Future<bool> deleteUser() async {
    try {
      await _firebaseAuth.currentUser?.delete();
      logout();
      return true;
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      return false;
    }
  }
}
