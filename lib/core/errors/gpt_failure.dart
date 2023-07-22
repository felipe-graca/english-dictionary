import 'package:english_dictionary/core/errors/failure.dart';

class GptFailure extends Failure {
  GptFailure({String message = 'Something went wrong at GPT'}) : super(message: message);
}
