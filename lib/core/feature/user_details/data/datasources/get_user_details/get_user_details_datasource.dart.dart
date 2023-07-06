import 'package:english_dictionary/core/errors/failure.dart';
import 'package:english_dictionary/core/feature/user_details/core/errors/user_details_failure.dart';
import 'package:english_dictionary/core/feature/user_details/data/datasources/get_user_details/get_user_details_datasource_interface.dart';
import 'package:english_dictionary/core/feature/user_details/data/models/user_data_model.dart';
import 'package:english_dictionary/core/services/firebase/firebase_service_interface.dart';

class GetUserDetailsDatasource implements IGetUserDetailsDatasource {
  final IFirebaseService _firebaseService;

  GetUserDetailsDatasource(this._firebaseService);

  @override
  Future<UserDataModel> getUserDetails() async {
    try {
      final result = await _firebaseService.getUserDetails();

      return UserDataModel.fromMap(result);
    } on FirebaseFailure {
      throw SaveUserFailure();
    }
  }
}
