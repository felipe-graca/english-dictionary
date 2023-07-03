import 'package:english_dictionary/core/errors/failure.dart';

class WordsFailure extends Failure {
  WordsFailure({String message = 'Something went wrong at Words'}) : super(message: message);
}

class GetWordsFailure extends Failure {
  GetWordsFailure({String message = 'Something went wrong at Get Words'}) : super(message: message);
}
