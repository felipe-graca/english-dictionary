abstract interface class IFirebaseService {
  //auth
  Future<bool> signInWithGoogle();

  //user
  Future<bool> saveUser(Map<String, dynamic> map);
  Future<Map<String, dynamic>> getUserDetails();
  Future<bool> existsUser();

  //words
  Future<List<Map<String, dynamic>>> getWords();

  //favorites
  Future<bool> saveFavoriteWord(Map<String, dynamic> map);
  Future<bool> removeFavoriteWord(Map<String, dynamic> map);
  Future<List<Map<String, dynamic>>> getFavoritesWords();

  //history
  Future<bool> saveHistoryWord(Map<String, dynamic> map);
  Future<bool> clearHistoryWords();
  Future<List<Map<String, dynamic>>> getHistoryWords();
}
