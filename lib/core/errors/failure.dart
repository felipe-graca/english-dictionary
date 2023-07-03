import 'package:firebase_core/firebase_core.dart';

class Failure implements Exception {
  final String message;
  Failure({required this.message});
}

class FirebaseFailure extends FirebaseException {
  FirebaseFailure({required super.plugin});
}
