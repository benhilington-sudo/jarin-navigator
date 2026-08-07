import 'package:just_audio/just_audio.dart';
import 'package:flutter/foundation.dart';

AudioPlayer? _player;

void playAudio(String path) async {
  try {
    await _player?.stop();
    _player ??= AudioPlayer();
    await _player!.setAsset(path);
    await _player!.play();
  } catch (e) {
    debugPrint('TTS play error: $e');
  }
}
