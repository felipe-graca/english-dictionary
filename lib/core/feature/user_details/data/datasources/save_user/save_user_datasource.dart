import 'package:english_dictionary/core/feature/user_details/core/errors/user_details_failure.dart';
import 'package:english_dictionary/core/feature/user_details/data/datasources/save_user/save_user_datasource_interface.dart';
import 'package:english_dictionary/core/feature/user_details/data/models/user_details_model.dart';

import 'package:english_dictionary/core/services/firebase/firebase_service_interface.dart';

class SaveUserDatasource implements ISaveUserDatasource {
  final IFirebaseService _firebaseService;

  SaveUserDatasource(this._firebaseService);

  @override
  Future<bool> saveUser(UserDetailsModel model) async {
    try {
      return await _firebaseService.saveUser(model.toMap());
    } on SaveUserFailure catch (e) {
      throw SaveUserFailure(message: e.message);
    }
  }
}
