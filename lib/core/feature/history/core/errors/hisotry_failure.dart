import 'package:english_dictionary/core/errors/failure.dart';

class HistoryFailure extends Failure {
  HistoryFailure({String message = 'Something went wrong at words'}) : super(message: message);
}

class SaveHistoryWordFailure extends HistoryFailure {
  SaveHistoryWordFailure({String message = 'Something went wrong at Save history Word'}) : super(message: message);
}

class GetHistoryWordsFailure extends HistoryFailure {
  GetHistoryWordsFailure({String message = 'Something went wrong at get history words'}) : super(message: message);
}

class ClearHistoryWordsFailure extends HistoryFailure {
  ClearHistoryWordsFailure({String message = 'Something went wrong at clear history words'}) : super(message: message);
}
