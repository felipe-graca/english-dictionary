import 'package:english_dictionary/core/feature/user_details/data/models/user_details_model.dart';

abstract interface class ISaveUserDatasource {
  Future<bool> saveUser(UserDetailsModel model);
}
