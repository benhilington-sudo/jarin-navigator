import 'package:flutter/foundation.dart';

import 'tts_web.dart' if (dart.library.io) 'tts_stub.dart';

class TtsService {
  final dynamic settings;

  TtsService(this.settings);

  Future<void> speak(String text) async {
    try {
      final lower = text.toLowerCase();
      debugPrint('TTS speak: $text');

      if (lower.contains('приятной поездки') ||
          lower.contains('хорошей дороги') ||
          lower.contains('good road') ||
          lower.contains('nice trip')) {
        debugPrint('TTS -> voice_welcome');
        playAudio('assets/voice/voice_welcome.mp3');
      } else if (lower.contains('направо') ||
          lower.contains('turn right') ||
          lower.contains('поверните направо')) {
        debugPrint('TTS -> voice_turn_right');
        playAudio('assets/voice/voice_turn_right.mp3');
      } else if (lower.contains('налево') ||
          lower.contains('turn left') ||
          lower.contains('поверните налево')) {
        debugPrint('TTS -> voice_turn_left');
        playAudio('assets/voice/voice_turn_left.mp3');
      } else {
        debugPrint('TTS -> no match for: $text');
      }
    } catch (e) {
      debugPrint('TTS speak error: $e');
    }
  }

  Future<void> stop() async {}
}
