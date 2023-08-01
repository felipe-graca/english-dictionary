import 'package:english_dictionary/core/errors/firebase_failure.dart';
import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/user_details/data/datasources/exists_user/exists_user_datasource.dart';
import 'package:english_dictionary/core/services/firebase/firestore_service_interface.dart';

class ExistsUserDatasource implements IExistsUserDatasource {
  final IFirestoreService _firestoreService;

  ExistsUserDatasource(this._firestoreService);

  @override
  Future<bool> existsUser() async {
    try {
      return await _firestoreService.existsUser();
    } on FirebaseFailure {
      throw ExistsUserFailure();
    }
  }
}
