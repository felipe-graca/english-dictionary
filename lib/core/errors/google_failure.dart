import 'package:flutter/services.dart';

class GoogleFailure extends PlatformException {
  GoogleFailure({String message = 'Something went wrong at Google'}) : super(code: message);
}

class GoogleSignInFailure extends GoogleFailure {
  GoogleSignInFailure({String message = 'Something went wrong at Google SignIn'}) : super(message: message);

  factory GoogleSignInFailure.getGoogleSignInErrorMessage(
    String? e, [
    String defaultMessag = 'Something went wrong at Google SignIn',
  ]) {
    if (e == null) return GoogleSignInFailure(message: defaultMessag);
    String errorMessage = "An unknown error occurred.";

    switch (e) {
      case 'sign_in_failed':
        errorMessage = "Google Sign-In failed.";
        break;
      case 'network_error':
        errorMessage = "Network error occurred. Please check your internet connection.";
        break;
      case 'invalid_client_id':
        errorMessage = "Invalid client ID. Please check your configuration.";
        break;
      case 'user_canceled':
        errorMessage = "User canceled the sign-in process.";
        break;
      case 'user_disabled':
        errorMessage = "User account has been disabled.";
        break;
      case 'user_token_expired':
        errorMessage = "User token has expired.";
        break;
      default:
        errorMessage = "An error occurred";
        break;
    }

    return GoogleSignInFailure(message: errorMessage);
  }
}
