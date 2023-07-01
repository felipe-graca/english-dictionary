import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/auth/data/datasource/exists_user/exists_user_datasource.dart';
import 'package:english_dictionary/core/services/firebase/firebase_service_interface.dart';

class ExistsUserDatasource implements IExistsUserDatasource {
  final IFirebaseService _firebaseService;

  ExistsUserDatasource(this._firebaseService);

  @override
  Future<bool> existsUser() async {
    try {
      return await _firebaseService.existsUser();
    } on ExistsUserFailuire catch (e) {
      throw ExistsUserFailuire(message: e.toString());
    }
  }
}
