import 'package:english_dictionary/core/errors/failure.dart';

class UserDetailsFailure extends Failure {
  UserDetailsFailure({String message = 'Something went wrong with get user details'}) : super(message: message);
}

class GetUserDatailsFailure extends UserDetailsFailure {
  GetUserDatailsFailure({String message = 'Something went wrong with get user data'}) : super(message: message);
}

class UpdateUserDatailsFailure extends UserDetailsFailure {
  UpdateUserDatailsFailure({String message = 'Something went wrong with update user data'}) : super(message: message);
}

class SaveUserFailure extends UserDetailsFailure {
  SaveUserFailure({String message = 'Something went wrong with save user data'}) : super(message: message);
}

class UpdateImageProfileFailure extends UserDetailsFailure {
  UpdateImageProfileFailure({String message = 'Something went wrong with update image profile'}) : super(message: message);
}
