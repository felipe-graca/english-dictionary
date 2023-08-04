import 'package:english_dictionary/core/errors/failure.dart';

class FirestoreFailure extends Failure {
  FirestoreFailure({String message = 'Something went wrong at Firebase'}) : super(message: message);
}
