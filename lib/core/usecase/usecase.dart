import 'package:english_dictionary/core/errors/failure.dart';

abstract class UseCase<Output, Input> {
  Future<(Failure?, Output)> call(Input params);
}

class NoParams {
  const NoParams._internal();
}

const NoParams noParams = NoParams._internal();
