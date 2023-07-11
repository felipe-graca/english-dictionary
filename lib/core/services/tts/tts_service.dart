import 'package:english_dictionary/core/services/tts/tts_service_interface.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TtsService implements ITtsService {
  final _flutterTts = FlutterTts();

  int currentPosition = 0;

  @override
  Future<void> setup() async {
    await _flutterTts.setLanguage('en-US');
    await _flutterTts.setSpeechRate(0.7);
    await _flutterTts.setVolume(1);
    await _flutterTts.setPitch(1);
  }

  @override
  Future<bool> speak(String text) async {
    try {
      await _flutterTts.speak(text);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> stop() async {
    try {
      await _flutterTts.stop();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> pause() async {
    try {
      await _flutterTts.pause();
      return true;
    } catch (e) {
      return false;
    }
  }
}
