abstract interface class IImageConverterService {
  Future<String> convertImageToBase64(String path);
}
