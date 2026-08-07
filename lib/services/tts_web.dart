import 'dart:js_interop';

@JS('jarinPlayAudio')
external void _jarinPlayAudio(String path);

void playAudio(String path) {
  var url = path;
  // In Flutter web builds assets are served under /assets/ prefix,
  // so pubspec path "assets/voice/x.mp3" becomes "assets/assets/voice/x.mp3"
  if (url.startsWith('assets/') && !url.startsWith('assets/assets/')) {
    url = 'assets/$url';
  }
  _jarinPlayAudio(url);
}
