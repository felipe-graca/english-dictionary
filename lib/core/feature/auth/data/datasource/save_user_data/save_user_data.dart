import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/auth/data/datasource/save_user_data/save_user_data_interface.dart';
import 'package:english_dictionary/core/feature/auth/data/model/user_data_model.dart';
import 'package:english_dictionary/core/services/firebase/firebase_service_interface.dart';

class SaveUserDatasource implements ISaveUserDatasource {
  final IFirebaseService _firebaseService;

  SaveUserDatasource(this._firebaseService);

  @override
  Future<bool> saveUser(UserDataModel model) async {
    try {
      return _firebaseService.saveUser(model);
    } on SaveUserFailure catch (e) {
      throw SaveUserFailure(message: e.message);
    }
  }
}
