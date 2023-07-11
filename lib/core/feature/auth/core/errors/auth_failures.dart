import 'package:english_dictionary/core/errors/failure.dart';

class AuthFailure extends Failure {
  AuthFailure({String message = 'Something went wrong'}) : super(message: message);
}

class LoginFailure extends AuthFailure {
  LoginFailure({String message = "Login failed. Please check your internet connection and try again."}) : super(message: message);
}

class ExistsUserFailuire extends AuthFailure {
  ExistsUserFailuire({String message = "Failed to check if user exists. Please check your internet connection and try again."})
      : super(message: message);
}
