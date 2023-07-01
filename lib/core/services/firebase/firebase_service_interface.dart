import 'package:english_dictionary/core/feature/auth/data/model/user_data_model.dart';

abstract class IFirebaseService {
  Future<bool> signInWithGoogle();
  Future<bool> saveUser(UserDataModel model);
  Future<UserDataModel> getUserDetails();
  Future<bool> existsUser();
}
