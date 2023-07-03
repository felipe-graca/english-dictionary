abstract interface class ITtsService {
  Future<void> setup();
  Future<bool> speak(String text);
  Future<bool> stop();
  Future<bool> pause();
}
