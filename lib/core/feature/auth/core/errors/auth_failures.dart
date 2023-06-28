import 'package:english_dictionary/core/errors/failure.dart';

class AuthFailure extends Failure {
  final String message;

  AuthFailure({this.message = 'Something went wrong'});
}

class LoginFailure extends AuthFailure {
  LoginFailure({String message = "Login failed. Please check your internet connection and try again."}) : super(message: message);
}
