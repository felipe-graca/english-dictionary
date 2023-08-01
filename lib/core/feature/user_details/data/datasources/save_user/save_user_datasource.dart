import 'package:english_dictionary/core/errors/firebase_failure.dart';
import 'package:english_dictionary/core/feature/user_details/core/errors/user_details_failure.dart';
import 'package:english_dictionary/core/feature/user_details/data/datasources/save_user/save_user_datasource_interface.dart';
import 'package:english_dictionary/core/feature/user_details/data/models/user_details_model.dart';

import 'package:english_dictionary/core/services/firebase/firestore_service_interface.dart';

class SaveUserDatasource implements ISaveUserDatasource {
  final IFirestoreService _firestoreService;

  SaveUserDatasource(this._firestoreService);

  @override
  Future<bool> saveUser(UserDetailsModel model) async {
    try {
      return await _firestoreService.saveUser(model.toMap());
    } on FirebaseFailure {
      throw SaveUserFailure();
    }
  }
}
