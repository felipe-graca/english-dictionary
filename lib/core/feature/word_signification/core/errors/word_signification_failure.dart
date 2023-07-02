import 'package:english_dictionary/core/errors/failure.dart';

class WordSignificationFailure extends Failure {
  WordSignificationFailure({String message = 'Something went wrong with word signification'}) : super();
}

class GetWordSignificationFailure extends WordSignificationFailure {
  GetWordSignificationFailure({String message = "Failed to get word signification. Please check your internet connection and try again."})
      : super(message: message);
}
