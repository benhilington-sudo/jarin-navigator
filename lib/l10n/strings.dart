class Strings {
  final bool isRu;

  const Strings({required this.isRu});

  String get appName => 'Jarin';

  String get tagline =>
      isRu ? 'Умный навигатор по всему миру' : 'Smart navigator for the world';

  String get welcome => isRu ? 'Добро пожаловать' : 'Welcome';

  String get loginWithEmail =>
      isRu ? 'Войти через Email' : 'Sign in with Email';

  String get loginWithGoogle =>
      isRu ? 'Войти через Google' : 'Sign in with Google';

  String get registerWithEmail =>
      isRu ? 'Зарегистрироваться' : 'Create account';

  String get email => isRu ? 'Email' : 'Email';

  String get password => isRu ? 'Пароль' : 'Password';

  String get name => isRu ? 'Имя' : 'Name';

  String get login => isRu ? 'Войти' : 'Sign in';

  String get register => isRu ? 'Создать аккаунт' : 'Create account';

  String get noAccount => isRu ? 'Нет аккаунта? Зарегистрируйтесь' : "Don't have an account? Register";

  String get haveAccount => isRu ? 'Уже есть аккаунт? Войти' : 'Already have an account? Sign in';

  String get verificationTitle => isRu ? 'Подтверждение email' : 'Verify your email';

  String get verificationHint =>
      isRu ? 'Мы отправили код на вашу почту' : 'We sent a code to your email';

  String get demoCode => isRu ? 'Демо-режим: код 123456' : 'Demo mode: code 123456';

  String get verify => isRu ? 'Подтвердить' : 'Verify';

  String get wrongCode => isRu ? 'Неверный код. Попробуйте ещё раз' : 'Wrong code. Try again';

  String get invalidEmail => isRu ? 'Введите корректный email' : 'Enter a valid email';

  String get shortPassword => isRu ? 'Минимум 6 символов' : 'At least 6 characters';

  String get googleSimulated =>
      isRu ? 'Вход через Google (демо)' : 'Google sign-in (demo)';

  String get searchHint =>
      isRu ? 'Куда едем?' : 'Where to?';

  String get searchPlaceholder =>
      isRu ? 'Поиск адреса или места…' : 'Search address or place…';

  String get routeTime => isRu ? 'в пути' : 'ETA';

  String get findRoute => isRu ? 'Маршрут' : 'Route';

  String get navigate => isRu ? 'Поехали' : 'Go';

  String get cancelRoute => isRu ? 'Завершить' : 'Stop';

  String get navigation => isRu ? 'Навигатор' : 'Navigator';

  String get searchTab => isRu ? 'Поиск' : 'Search';

  String get settingsTab => isRu ? 'Настройки' : 'Settings';

  String get settings => isRu ? 'Настройки' : 'Settings';

  String get themeSection => isRu ? 'Тема' : 'Theme';

  String get darkTheme => isRu ? 'Чёрная тема' : 'Dark theme';

  String get lightTheme => isRu ? 'Светлая тема' : 'Light theme';

  String get languageSection => isRu ? 'Язык' : 'Language';

  String get voiceSection => isRu ? 'Голос «Лоад»' : 'Voice "Load"';

  String get voiceDesc =>
      isRu
          ? 'Настройки ассистента: тембр, скорость, шёпот'
          : 'Assistant settings: pitch, rate, whisper';

  String get voiceConfigure => isRu ? 'Настроить голос' : 'Configure voice';

  String get pitch => isRu ? 'Тембр голоса' : 'Voice pitch';

  String get low => isRu ? 'Низкий' : 'Low';
  String get high => isRu ? 'Высокий' : 'High';

  String get speechRate => isRu ? 'Скорость речи' : 'Speech rate';

  String get whisperMode => isRu ? 'Режим шёпота' : 'Whisper mode';

  String get whisperDesc =>
      isRu ? 'Тихие подсказки, не мешающие пассажирам' : 'Quiet hints for passengers';

  String get testVoice => isRu ? 'Проверить голос' : 'Test voice';

  String get testVoiceText =>
      isRu ? 'Добрый день! Я Лоад, ваш навигатор.' : 'Hello! I am Load, your navigator.';

  String get goodRoad =>
      isRu ? 'Приятной поездки!' : 'Have a nice trip!';

  String get turnRight => isRu ? 'Через 300 метров поверните направо' : 'In 300 meters turn right';

  String get turnLeft => isRu ? 'Через 300 метров поверните налево' : 'In 300 meters turn left';

  String get goStraight => isRu ? 'Двигайтесь прямо' : 'Go straight';

  String get routeRebuilt => isRu ? 'Маршрут перестроен' : 'Route recalculated';

  String get arrival => isRu ? 'Вы прибыли' : 'You have arrived';

  String get proactiveMorning =>
      isRu ? 'Обычно вы едете на работу. Проложить маршрут?' : 'You usually go to work. Plan the route?';

  String get proactiveEvening =>
      isRu ? 'Похоже, пора домой. Проложить маршрут?' : 'Time to head home. Plan the route?';

  String get suggested => isRu ? 'Предложения' : 'Suggestions';

  String get favoriteHome => isRu ? 'Дом' : 'Home';

  String get favoriteWork => isRu ? 'Работа' : 'Work';

  String get minutesShort => isRu ? 'мин' : 'min';

  String get kmh => isRu ? 'км/ч' : 'km/h';

  String get meters => isRu ? 'м' : 'm';

  String get kilometers => isRu ? 'км' : 'km';

  String get cameras => isRu ? 'Камеры' : 'Cameras';

  String get speedCamera => isRu ? 'Камера скорости' : 'Speed camera';

  String get trafficLightCamera => isRu ? 'Светофорная камера' : 'Traffic light camera';

  String get laneCamera => isRu ? 'Камера контроля полос' : 'Lane control camera';

  String get redLightCamera => isRu ? 'Камера контроля проезда' : 'Red light camera';

  String get limit => isRu ? 'лимит' : 'limit';

  String get speed => isRu ? 'Скорость' : 'Speed';

  String get distanceLeft => isRu ? 'осталось' : 'left';

  String get arrivalTime => isRu ? 'Прибытие' : 'Arrival';

  String get trafficFactorNote =>
      isRu ? 'С учётом трафика' : 'Including traffic';

  String get account => isRu ? 'Аккаунт' : 'Account';

  String get logout => isRu ? 'Выйти' : 'Log out';

  String get about => isRu ? 'О приложении' : 'About';

  String get aboutText =>
      isRu
          ? 'Jarin — современный навигатор с глобальной картой мира, голосовым ассистентом «Лоад» и умными маршрутами.'
          : 'Jarin — a modern navigator with a world map, the "Load" voice assistant and smart routes.';

  String get version => isRu ? 'Версия 1.0.0' : 'Version 1.0.0';

  String get arrivedNote =>
      isRu ? 'Приятного пути с Jarin!' : 'Enjoy your trip with Jarin!';
}
