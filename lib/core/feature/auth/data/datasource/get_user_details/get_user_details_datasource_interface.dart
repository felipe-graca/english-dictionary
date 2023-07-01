import 'package:english_dictionary/core/feature/auth/data/model/user_data_model.dart';

abstract class IGetUserDetailsDatasource {
  Future<UserDataModel> getUserDetails();
}
