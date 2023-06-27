class Failure implements Exception {}

class SmolFailure extends Failure {
  final String message;

  SmolFailure([this.message = '']);

  @override
  String toString() => message;
}
