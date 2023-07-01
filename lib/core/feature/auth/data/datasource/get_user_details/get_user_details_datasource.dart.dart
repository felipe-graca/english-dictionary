import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/auth/data/datasource/get_user_details/get_user_details_datasource_interface.dart';
import 'package:english_dictionary/core/feature/auth/data/model/user_data_model.dart';
import 'package:english_dictionary/core/services/firebase/firebase_service_interface.dart';

class GetUserDetailsDatasource implements IGetUserDetailsDatasource {
  final IFirebaseService _firebaseService;

  GetUserDetailsDatasource(this._firebaseService);

  @override
  Future<UserDataModel> getUserDetails() async {
    try {
      return await _firebaseService.getUserDetails();
    } on GetUserDetailsFailure catch (e) {
      throw GetUserDetailsFailure(message: e.message);
    }
  }
}
