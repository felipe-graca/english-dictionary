abstract interface class IFirebaseService {
  Future<bool> signInWithGoogle();
  Future<bool> saveUser(Map<String, dynamic> map);
  Future<Map<String, dynamic>> getUserDetails();
  Future<bool> existsUser();
  Future<List<Map<String, dynamic>>> getWords();
}
