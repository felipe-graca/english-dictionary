import 'package:english_dictionary/core/errors/failure.dart';

class AuthFailure extends Failure {
  final String message;

  AuthFailure({this.message = 'Something went wrong'});
}

class LoginFailure extends AuthFailure {
  LoginFailure({String message = "Login failed. Please check your internet connection and try again."}) : super(message: message);
}

class SaveUserFailure extends AuthFailure {
  SaveUserFailure({String message = "Failed to save user. Please check your internet connection and try again."}) : super(message: message);
}

class InitializeUserFailure extends AuthFailure {
  InitializeUserFailure({String message = "Failed to initialize user. Please check your internet connection and try again."})
      : super(message: message);
}

class GetUserDetailsFailure extends AuthFailure {
  GetUserDetailsFailure({String message = "Failed to get user details. Please check your internet connection and try again."})
      : super(message: message);
}

class ExistsUserFailuire extends AuthFailure {
  ExistsUserFailuire({String message = "Failed to check if user exists. Please check your internet connection and try again."})
      : super(message: message);
}
