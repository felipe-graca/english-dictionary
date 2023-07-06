import 'package:english_dictionary/core/feature/user_details/data/models/user_data_model.dart';

abstract interface class IGetUserDetailsDatasource {
  Future<UserDataModel> getUserDetails();
}
