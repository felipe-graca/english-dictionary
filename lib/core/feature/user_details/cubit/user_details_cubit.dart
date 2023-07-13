import 'dart:convert';

import 'package:english_dictionary/core/feature/user_details/domain/usecases/exists_user/exists_user_usecase_interface.dart';
import 'package:english_dictionary/core/feature/user_details/domain/entities/user_details_entity.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/get_user_details/get_user_details_usecase_interface.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/save_user/save_user_usecase_interface.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'user_details_state.dart';

class UserDetailsCubit extends Cubit<UserDetailsState> {
  final IGetUserDetailsUsecase getUserDetailsUsecase;
  final IExistsUserUsecase existsUserUsecase;
  final ISaveUserUsecase saveUserUsecase;

  UserDetailsCubit(this.getUserDetailsUsecase, this.existsUserUsecase, this.saveUserUsecase) : super(const UserDetailsState());

  final firebaseAuth = FirebaseAuth.instance;
  final imagePicker = ImagePicker();

  Future<bool> initializeUserDetails() async {
    final existsUser = await _existsUser();
    if (!existsUser) {
      return await _createUserDetails();
    }

    return await _getUserDetails();
  }

  Future<bool> _existsUser() async {
    final result = await existsUserUsecase.call(noParams);
    return result.fold(
      (failure) {
        emit(state.copyWith(errorMessage: failure.message));
        return false;
      },
      (success) => success,
    );
  }

  Future<bool> _createUserDetails() async {
    final userDetails = UserDetailsEntity(
      name: firebaseAuth.currentUser?.displayName ?? '',
      email: firebaseAuth.currentUser?.email ?? '',
      base64Image: firebaseAuth.currentUser?.photoURL ?? '',
      uid: firebaseAuth.currentUser?.uid ?? '',
    );
    final result = await saveUserUsecase.call(userDetails);
    return result.fold(
      (failure) {
        emit(state.copyWith(errorMessage: failure.message));
        return false;
      },
      (success) {
        emit(state.copyWith(userDetails: userDetails));
        return success;
      },
    );
  }

  Future<bool> _getUserDetails() async {
    final result = await getUserDetailsUsecase.call(noParams);
    return result.fold(
      (failure) {
        emit(state.copyWith(errorMessage: failure.message));
        return false;
      },
      (success) {
        emit(state.copyWith(userDetails: success));
        return true;
      },
    );
  }

  Future<void> changeImageProfile(String base64) async {
    emit(state.copyWith(userDetails: state.userDetails.copyWith(base64Image: base64)));
  }

  //Picker image
  Future<void> pickImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      await changeImageProfile(await _xFileToBase64(pickedFile)).then((_) async {
        await _updateUserDetails();
      });
    }
  }

  //Xfile to base64
  Future<String> _xFileToBase64(XFile file) async {
    final bytes = await file.readAsBytes();
    return base64Encode(bytes);
  }

  Future<bool> _updateUserDetails() async {
    final result = await saveUserUsecase.call(state.userDetails);
    return result.fold(
      (failure) {
        emit(state.copyWith(errorMessage: failure.message));
        return false;
      },
      (success) => success,
    );
  }
}
