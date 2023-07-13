import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:english_dictionary/core/feature/user_details/core/services/image_converter/image_converter_service_interface.dart';
import 'package:english_dictionary/core/services/http/http_service_interface.dart';

class ImageConverterService implements IImageConverterService {
  final IHttpService _httpService;

  ImageConverterService(this._httpService);

  @override
  Future<String> convertImageToBase64(String path) async {
    if (path.isEmpty) {
      return '';
    }
    final tempDir = Directory.systemTemp;
    final filePath = '${tempDir.path}/image.jpg';
    File file = File(filePath);

    await file.writeAsBytes(await _downloadImage(path));
    return await _fileToBase64(file);
  }

  Future<Uint8List> _downloadImage(String path) async {
    final response = await _httpService.download(path);
    return response.data;
  }

  //File to base64
  Future<String> _fileToBase64(File file) async {
    final bytes = await file.readAsBytes();
    return base64Encode(bytes);
  }
}
