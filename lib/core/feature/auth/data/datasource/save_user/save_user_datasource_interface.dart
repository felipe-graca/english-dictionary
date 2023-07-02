import 'package:english_dictionary/core/feature/auth/data/model/user_data_model.dart';

abstract interface class ISaveUserDatasource {
  Future<bool> saveUser(UserDataModel model);
}
