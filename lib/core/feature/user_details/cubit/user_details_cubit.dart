import 'package:english_dictionary/core/feature/history/cubit/history_cubit.dart';
import 'package:english_dictionary/core/feature/user_details/core/errors/user_details_failure.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/exists_user/exists_user_usecase_interface.dart';
import 'package:english_dictionary/core/feature/user_details/domain/entities/user_details_entity.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/get_user_details/get_user_details_usecase_interface.dart';
import 'package:english_dictionary/core/feature/user_details/domain/usecases/save_user/save_user_usecase_interface.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';
import 'package:english_dictionary/core/services/auth/auth_service_interface.dart';
import 'package:english_dictionary/core/services/storage/storage_service_interface.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

part 'user_details_state.dart';

class UserDetailsCubit extends Cubit<UserDetailsState> {
  final IGetUserDetailsUsecase getUserDetailsUsecase;
  final IExistsUserUsecase existsUserUsecase;
  final ISaveUserUsecase saveUserUsecase;
  final IAuthService _authService;
  final IStorageService storageService;

  UserDetailsCubit(
    this.getUserDetailsUsecase,
    this.existsUserUsecase,
    this.saveUserUsecase,
    this.storageService,
    this._authService,
  ) : super(const UserDetailsState());

  final imagePicker = ImagePicker();

  Future<bool> initializeUserDetails() async {
    final existsUser = await _existsUser();
    if (!existsUser) {
      return await _createUserDetails();
    }

    return await _getUserDetails();
  }

  Future<bool> _existsUser() async {
    final (failure, result) = await existsUserUsecase.call(noParams);
    if (failure != null) {
      emit(state.copyWith(errorMessage: failure.message));
    }
    return result;
  }

  Future<bool> _createUserDetails() async {
    try {
      final userDetails = UserDetailsEntity(
        uid: _authService.currentAuthUserDetails?.uid ?? '',
        name: _authService.currentAuthUserDetails?.displayName ?? '',
        email: _authService.currentAuthUserDetails?.email ?? '',
        imagePath: _authService.currentAuthUserDetails?.photoURL ?? '',
        countWords: 0,
      );
      final (failure, result) = await saveUserUsecase.call(userDetails);

      if (result) {
        emit(state.copyWith(userDetails: userDetails));
        return result;
      }
      emit(state.copyWith(errorMessage: failure!.message));
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<bool> _getUserDetails() async {
    final (failure, result) = await getUserDetailsUsecase.call(noParams);

    if (!result.isEmpty) {
      emit(state.copyWith(userDetails: result));
      return true;
    }

    emit(state.copyWith(errorMessage: failure!.message));
    return false;
  }

  Future<bool> changeImageProfile() async {
    try {
      final imagePath = await _pickImage();
      if (imagePath.isNotEmpty) {
        emit(state.copyWith(loading: true));
        if (await _uploadImage(imagePath)) {
          await _updateUserDetails();
          emit(state.copyWith(loading: false));
          return true;
        }
      }
      emit(state.copyWith(errorMessage: UpdateImageProfileFailure().message));
      return false;
    } catch (e) {
      emit(state.copyWith(loading: false, errorMessage: UpdateImageProfileFailure().message));
      return false;
    }
  }

  //Picker image
  Future<String> _pickImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return pickedFile.path;
    }
    return '';
  }

  Future<bool> _uploadImage(String imagePath) async {
    try {
      final imageUrl = await storageService.saveImage('users', userName: state.userDetails.name, imagePath: imagePath);
      if (imageUrl == null) {
        return false;
      }
      emit(state.copyWith(userDetails: state.userDetails.copyWith(imagePath: imageUrl)));
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> _updateUserDetails() async {
    final (failure, result) = await saveUserUsecase.call(state.userDetails);
    emit(state.copyWith(errorMessage: failure!.message));

    return result;
  }

  Future<void> addWordToCountOfNewWords(WordEntity word) async {
    final historyWords = GetIt.I.get<HistoryCubit>().state.words;
    for (final historyWord in historyWords) {
      if (historyWord.word == word.word) {
        return;
      }
    }
    final userDetails = state.userDetails.copyWith(countWords: state.userDetails.countWords + 1);
    final (failure, result) = await saveUserUsecase.call(userDetails);

    if (result) {
      emit(state.copyWith(userDetails: userDetails));
      return;
    }
    emit(state.copyWith(errorMessage: failure!.message));
  }
}
