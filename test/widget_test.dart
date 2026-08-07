import 'package:flutter_test/flutter_test.dart';
import 'package:jarin_navigator/l10n/strings.dart';
import 'package:jarin_navigator/services/navigation_engine.dart';
import 'package:jarin_navigator/services/settings_service.dart';
import 'package:jarin_navigator/services/tts_service.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
  });

  test('Русская локализация по умолчанию', () {
    final s = const Strings(isRu: true);
    expect(s.turnRight, 'Поверните направо');
    expect(s.goodRoad, 'Хорошей дороги!');
  });

  test('Английская локализация', () {
    final s = const Strings(isRu: false);
    expect(s.turnRight, 'Turn right');
    expect(s.routeRebuilt, 'Route recalculated');
  });

  test('Движок инициализируется в режиме ожидания', () async {
    final settings = SettingsService();
    await settings.load();
    final engine = NavigationEngine(settings, TtsService(settings));
    expect(engine.isIdle, true);
    expect(engine.isActive, false);
    expect(engine.isSelecting, false);
    expect(engine.isLoading, false);
    engine.dispose();
  });

  test('Установка GPS позиции', () async {
    final settings = SettingsService();
    await settings.load();
    final engine = NavigationEngine(settings, TtsService(settings));
    engine.setGpsPosition(const LatLng(59.9343, 30.3351));
    expect(engine.position, const LatLng(59.9343, 30.3351));
    expect(engine.gpsAvailable, true);
    engine.dispose();
  });

  test('Отмена маршрута возвращает idle', () async {
    final settings = SettingsService();
    await settings.load();
    final engine = NavigationEngine(settings, TtsService(settings));
    engine.cancelRoute();
    expect(engine.isIdle, true);
    engine.dispose();
  });
}
