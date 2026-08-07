import 'dart:js_interop';

@JS('jarinPlayAudio')
external void _jarinPlayAudio(String path);

void playAudio(String path) {
  _jarinPlayAudio(path);
}
