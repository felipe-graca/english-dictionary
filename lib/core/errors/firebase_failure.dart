import 'package:english_dictionary/core/errors/failure.dart';

class FirebaseFailure extends Failure {
  FirebaseFailure({String message = 'Something went wrong at Firebase'}) : super(message: message);
}
