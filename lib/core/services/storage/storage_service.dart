import 'dart:io';

import 'package:english_dictionary/core/services/storage/storage_service_interface.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService implements IStorageService {
  late FirebaseStorage _firebaseStorage;

  StorageService() {
    const storageBucket = String.fromEnvironment('STORAGE_BUCKET');
    _firebaseStorage = FirebaseStorage.instanceFor(bucket: storageBucket);
  }

  @override
  Future<String> saveImage(String path, {required String userName, required String imagePath}) async {
    try {
      final result = await _firebaseStorage.ref('$path/$userName').putFile(File(imagePath));
      final downloadURL = await result.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      // TODO: Create a custom exception and throw it
      rethrow;
    }
  }
}
