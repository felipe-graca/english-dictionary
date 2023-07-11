import 'package:english_dictionary/core/feature/user_details/data/models/user_details_model.dart';

abstract interface class IGetUserDetailsDatasource {
  Future<UserDetailsModel> getUserDetails();
}
