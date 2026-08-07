class RussianCity {
  final String name;
  final String region;
  final double lat;
  final double lng;

  const RussianCity({
    required this.name,
    required this.region,
    required this.lat,
    required this.lng,
  });
}

const List<RussianCity> russianCities = [
  // ─── Москва и МО ───
  RussianCity(name: 'Москва', region: 'Москва', lat: 55.7558, lng: 37.6173),
  RussianCity(name: 'Видное', region: 'Московская область', lat: 55.5541, lng: 37.7006),
  RussianCity(name: 'Балашиха', region: 'Московская область', lat: 55.7420, lng: 37.9455),
  RussianCity(name: 'Химки', region: 'Московская область', lat: 55.8947, lng: 37.4350),
  RussianCity(name: 'Мытищи', region: 'Московская область', lat: 55.9156, lng: 37.7304),
  RussianCity(name: 'Одинцово', region: 'Московская область', lat: 55.6783, lng: 37.2742),
  RussianCity(name: 'Люберцы', region: 'Московская область', lat: 55.6761, lng: 37.8947),
  RussianCity(name: 'Королёв', region: 'Московская область', lat: 55.9167, lng: 37.8550),
  RussianCity(name: 'Подольск', region: 'Московская область', lat: 55.4304, lng: 37.5538),
  RussianCity(name: 'Красногорск', region: 'Московская область', lat: 55.8206, lng: 37.3314),
  RussianCity(name: 'Щёлково', region: 'Московская область', lat: 55.8833, lng: 37.9667),
  RussianCity(name: 'Орехово-Зуево', region: 'Московская область', lat: 55.8058, lng: 38.9617),
  RussianCity(name: 'Ногинск', region: 'Московская область', lat: 55.8550, lng: 38.4417),
  RussianCity(name: 'Домодедово', region: 'Московская область', lat: 55.4372, lng: 37.7586),
  RussianCity(name: 'Серпухов', region: 'Московская область', lat: 54.9142, lng: 37.4114),
  RussianCity(name: 'Павловский Посад', region: 'Московская область', lat: 55.7828, lng: 38.6528),
  RussianCity(name: 'Электросталь', region: 'Московская область', lat: 55.7906, lng: 38.4467),
  RussianCity(name: 'Коломна', region: 'Московская область', lat: 55.0794, lng: 38.7783),
  RussianCity(name: 'Жуковский', region: 'Московская область', lat: 55.5992, lng: 38.1211),
  RussianCity(name: 'Фрязино', region: 'Московская область', lat: 55.9603, lng: 38.0503),
  RussianCity(name: 'Истра', region: 'Московская область', lat: 55.9208, lng: 36.8597),
  RussianCity(name: 'Наро-Фоминск', region: 'Московская область', lat: 55.3872, lng: 36.7333),
  RussianCity(name: 'Волоколамск', region: 'Московская область', lat: 56.0333, lng: 35.9167),
  RussianCity(name: 'Раменское', region: 'Московская область', lat: 55.5689, lng: 38.1556),
  RussianCity(name: 'Лобня', region: 'Московская область', lat: 56.0136, lng: 37.4764),
  RussianCity(name: 'Долгопрудный', region: 'Московская область', lat: 55.9439, lng: 37.5131),
  RussianCity(name: 'Троицк', region: 'Московская область', lat: 55.4833, lng: 36.8833),
  RussianCity(name: 'Дзержинский', region: 'Московская область', lat: 55.6333, lng: 37.8500),
  RussianCity(name: 'Егорьевск', region: 'Московская область', lat: 55.3833, lng: 39.0333),
  RussianCity(name: 'Зарайск', region: 'Московская область', lat: 54.7667, lng: 38.8833),
  RussianCity(name: 'Кашира', region: 'Московская область', lat: 54.8333, lng: 38.1500),
  RussianCity(name: 'Красноармейск', region: 'Московская область', lat: 55.0667, lng: 38.2000),
  RussianCity(name: 'Лотошино', region: 'Московская область', lat: 56.2333, lng: 35.6667),
  RussianCity(name: 'Можайск', region: 'Московская область', lat: 55.5083, lng: 36.0200),
  RussianCity(name: 'Пушкино', region: 'Московская область', lat: 56.0100, lng: 37.8483),
  RussianCity(name: 'Ступино', region: 'Московская область', lat: 54.8869, lng: 37.3931),
  RussianCity(name: 'Чехов', region: 'Московская область', lat: 55.1500, lng: 37.4833),
  RussianCity(name: 'Шатура', region: 'Московская область', lat: 55.5667, lng: 39.5333),
  RussianCity(name: 'Юбилейный', region: 'Московская область', lat: 55.9261, lng: 37.8525),

  // ─── Санкт-Петербург и ЛО ───
  RussianCity(name: 'Санкт-Петербург', region: 'Санкт-Петербург', lat: 59.9343, lng: 30.3351),
  RussianCity(name: 'Колпино', region: 'Ленинградская область', lat: 59.7500, lng: 30.6000),
  RussianCity(name: 'Пушкин', region: 'Ленинградская область', lat: 60.0483, lng: 30.3283),
  RussianCity(name: 'Петергоф', region: 'Ленинградская область', lat: 59.8833, lng: 29.9000),
  RussianCity(name: 'Выборг', region: 'Ленинградская область', lat: 60.7100, lng: 28.7500),
  RussianCity(name: 'Кингисепп', region: 'Ленинградская область', lat: 59.3736, lng: 28.6136),
  RussianCity(name: 'Тосно', region: 'Ленинградская область', lat: 59.5400, lng: 30.8772),
  RussianCity(name: 'Гатчина', region: 'Ленинградская область', lat: 59.5764, lng: 30.1286),
  RussianCity(name: 'Кириши', region: 'Ленинградская область', lat: 59.4467, lng: 32.0217),
  RussianCity(name: 'Волхов', region: 'Ленинградская область', lat: 59.9267, lng: 32.3367),
  RussianCity(name: 'Луга', region: 'Ленинградская область', lat: 58.7333, lng: 29.8333),
  RussianCity(name: 'Приозерск', region: 'Ленинградская область', lat: 61.0333, lng: 30.1167),
  RussianCity(name: 'Ломоносов', region: 'Ленинградская область', lat: 59.9000, lng: 29.7667),
  RussianCity(name: 'Волосово', region: 'Ленинградская область', lat: 59.4500, lng: 29.4833),
  RussianCity(name: 'Сосновый Бор', region: 'Ленинградская область', lat: 59.9000, lng: 29.0833),

  // ─── Нижегородская область ───
  RussianCity(name: 'Нижний Новгород', region: 'Нижегородская область', lat: 56.2965, lng: 43.9361),
  RussianCity(name: 'Дзержинск', region: 'Нижегородская область', lat: 56.2333, lng: 43.4500),
  RussianCity(name: 'Арзамас', region: 'Нижегородская область', lat: 55.3967, lng: 43.8103),
  RussianCity(name: 'Саров', region: 'Нижегородская область', lat: 54.9333, lng: 43.3167),
  RussianCity(name: 'Кстово', region: 'Нижегородская область', lat: 56.1500, lng: 44.1833),
  RussianCity(name: 'Бор', region: 'Нижегородская область', lat: 56.3600, lng: 44.0600),
  RussianCity(name: 'Павлово', region: 'Нижегородская область', lat: 55.9667, lng: 43.0833),
  RussianCity(name: 'Балахна', region: 'Нижегородская область', lat: 56.4833, lng: 43.6000),
  RussianCity(name: 'Заволжье', region: 'Нижегородская область', lat: 56.6333, lng: 43.3833),
  RussianCity(name: 'Семёнов', region: 'Нижегородская область', lat: 56.7833, lng: 44.4667),

  // ─── Свердловская область ───
  RussianCity(name: 'Екатеринбург', region: 'Свердловская область', lat: 56.8389, lng: 60.6057),
  RussianCity(name: 'Нижний Тагил', region: 'Свердловская область', lat: 57.9167, lng: 59.9667),
  RussianCity(name: 'Каменск-Уральский', region: 'Свердловская область', lat: 56.4167, lng: 61.9333),
  RussianCity(name: 'Первоуральск', region: 'Свердловская область', lat: 56.7667, lng: 59.9333),
  RussianCity(name: 'Алапаевск', region: 'Свердловская область', lat: 57.8500, lng: 61.6833),
  RussianCity(name: 'Ирбит', region: 'Свердловская область', lat: 57.6833, lng: 63.0667),
  RussianCity(name: 'Красноуфимск', region: 'Свердловская область', lat: 56.6333, lng: 57.7667),
  RussianCity(name: 'Ревда', region: 'Свердловская область', lat: 56.8000, lng: 59.9333),
  RussianCity(name: 'Реж', region: 'Свердловская область', lat: 57.3333, lng: 61.4000),
  RussianCity(name: 'Сысерт', region: 'Свердловская область', lat: 56.5500, lng: 60.8167),
  RussianCity(name: 'Белоярский', region: 'Свердловская область', lat: 56.7500, lng: 60.4000),

  // ─── Челябинская область ───
  RussianCity(name: 'Челябинск', region: 'Челябинская область', lat: 55.1644, lng: 61.4368),
  RussianCity(name: 'Магнитогорск', region: 'Челябинская область', lat: 53.4000, lng: 59.0333),
  RussianCity(name: 'Златоуст', region: 'Челябинская область', lat: 55.1667, lng: 59.7000),
  RussianCity(name: 'Миасс', region: 'Челябинская область', lat: 55.0500, lng: 60.1000),
  RussianCity(name: 'Кыштым', region: 'Челябинская область', lat: 55.7139, lng: 60.5528),
  RussianCity(name: 'Копейск', region: 'Челябинская область', lat: 55.1167, lng: 61.6167),
  RussianCity(name: 'Сатка', region: 'Челябинская область', lat: 54.9167, lng: 59.0167),
  RussianCity(name: 'Озёрск', region: 'Челябинская область', lat: 55.7500, lng: 60.7000),
  RussianCity(name: 'Троицк', region: 'Челябинская область', lat: 54.0833, lng: 61.5667),
  RussianCity(name: 'Верхний Уфалей', region: 'Челябинская область', lat: 56.0500, lng: 60.2333),
  RussianCity(name: 'Аша', region: 'Челябинская область', lat: 54.9833, lng: 57.3000),
  RussianCity(name: 'Бакал', region: 'Челябинская область', lat: 54.9333, lng: 58.8000),

  // ─── Самарская область ───
  RussianCity(name: 'Самара', region: 'Самарская область', lat: 53.1959, lng: 50.1002),
  RussianCity(name: 'Тольятти', region: 'Самарская область', lat: 53.5078, lng: 49.4204),
  RussianCity(name: 'Сызрань', region: 'Самарская область', lat: 53.1581, lng: 48.4681),
  RussianCity(name: 'Новокуйбышевск', region: 'Самарская область', lat: 53.1000, lng: 49.9167),
  RussianCity(name: 'Чапаевск', region: 'Самарская область', lat: 52.9833, lng: 49.7167),
  RussianCity(name: 'Жигулёвск', region: 'Самарская область', lat: 53.4000, lng: 49.5000),
  RussianCity(name: 'Отрадный', region: 'Самарская область', lat: 53.3833, lng: 51.3500),
  RussianCity(name: 'Кинель', region: 'Самарская область', lat: 53.2333, lng: 50.7833),
  RussianCity(name: 'Октябрьск', region: 'Самарская область', lat: 53.1667, lng: 48.6667),

  // ─── Волгоградская область ───
  RussianCity(name: 'Волгоград', region: 'Волгоградская область', lat: 48.7080, lng: 44.5133),
  RussianCity(name: 'Волжский', region: 'Волгоградская область', lat: 48.7833, lng: 44.7500),
  RussianCity(name: 'Михайловка', region: 'Волгоградская область', lat: 50.0667, lng: 43.2500),
  RussianCity(name: 'Урюпинск', region: 'Волгоградская область', lat: 50.8000, lng: 42.0167),
  RussianCity(name: 'Фролово', region: 'Волгоградская область', lat: 49.7667, lng: 43.6667),
  RussianCity(name: 'Калач-на-Дону', region: 'Волгоградская область', lat: 48.6833, lng: 43.5333),
  RussianCity(name: 'Котельниково', region: 'Волгоградская область', lat: 47.6333, lng: 43.1500),

  // ─── Ростовская область ───
  RussianCity(name: 'Ростов-на-Дону', region: 'Ростовская область', lat: 47.2357, lng: 39.7015),
  RussianCity(name: 'Таганрог', region: 'Ростовская область', lat: 47.2333, lng: 38.9000),
  RussianCity(name: 'Шахты', region: 'Ростовская область', lat: 47.7000, lng: 40.2333),
  RussianCity(name: 'Новочеркасск', region: 'Ростовская область', lat: 47.4167, lng: 40.1000),
  RussianCity(name: 'Батайск', region: 'Ростовская область', lat: 47.1333, lng: 39.7500),
  RussianCity(name: 'Каменск-Шахтинский', region: 'Ростовская область', lat: 48.3167, lng: 40.5667),
  RussianCity(name: 'Аксай', region: 'Ростовская область', lat: 47.2667, lng: 39.8667),
  RussianCity(name: 'Волгодонск', region: 'Ростовская область', lat: 47.5167, lng: 42.2000),
  RussianCity(name: 'Белая Калитва', region: 'Ростовская область', lat: 48.1667, lng: 40.7833),
  RussianCity(name: 'Сальск', region: 'Ростовская область', lat: 46.4667, lng: 41.5333),

  // ─── Краснодарский край ───
  RussianCity(name: 'Краснодар', region: 'Краснодарский край', lat: 45.0355, lng: 38.9753),
  RussianCity(name: 'Сочи', region: 'Краснодарский край', lat: 43.5855, lng: 39.7231),
  RussianCity(name: 'Новороссийск', region: 'Краснодарский край', lat: 44.7239, lng: 37.7689),
  RussianCity(name: 'Темрюк', region: 'Краснодарский край', lat: 45.2833, lng: 37.3833),
  RussianCity(name: 'Армавир', region: 'Краснодарский край', lat: 44.9833, lng: 41.1167),
  RussianCity(name: 'Геленджик', region: 'Краснодарский край', lat: 44.5633, lng: 38.0772),
  RussianCity(name: 'Горячий Ключ', region: 'Краснодарский край', lat: 44.6333, lng: 39.1333),
  RussianCity(name: 'Туапсе', region: 'Краснодарский край', lat: 44.1000, lng: 39.0833),
  RussianCity(name: 'Белореченск', region: 'Краснодарский край', lat: 44.7667, lng: 39.8667),
  RussianCity(name: 'Лабинск', region: 'Краснодарский край', lat: 44.6333, lng: 40.7333),
  RussianCity(name: 'Курганинск', region: 'Краснодарский край', lat: 44.9833, lng: 40.6000),
  RussianCity(name: 'Ейск', region: 'Краснодарский край', lat: 46.7167, lng: 38.2667),
  RussianCity(name: 'Крымск', region: 'Краснодарский край', lat: 44.9333, lng: 37.9833),
  RussianCity(name: 'Славянск-на-Кубани', region: 'Краснодарский край', lat: 45.2500, lng: 38.1333),
  RussianCity(name: 'Приморско-Ахтарск', region: 'Краснодарский край', lat: 46.0500, lng: 38.1833),

  // ─── Воронежская область ───
  RussianCity(name: 'Воронеж', region: 'Воронежская область', lat: 51.6720, lng: 39.1843),
  RussianCity(name: 'Лиски', region: 'Воронежская область', lat: 50.9833, lng: 39.4833),
  RussianCity(name: 'Борисоглебск', region: 'Воронежская область', lat: 51.3667, lng: 42.0833),
  RussianCity(name: 'Богучар', region: 'Воронежская область', lat: 49.9333, lng: 40.5500),
  RussianCity(name: 'Бобров', region: 'Воронежская область', lat: 51.1000, lng: 40.0333),
  RussianCity(name: 'Эртиль', region: 'Воронежская область', lat: 51.2833, lng: 40.8000),
  RussianCity(name: 'Нововоронеж', region: 'Воронежская область', lat: 51.3167, lng: 39.2167),
  RussianCity(name: 'Павловск', region: 'Воронежская область', lat: 50.4500, lng: 40.0667),
  RussianCity(name: 'Семилуки', region: 'Воронежская область', lat: 51.6833, lng: 39.4333),
  RussianCity(name: 'Россошь', region: 'Воронежская область', lat: 50.1833, lng: 39.5500),
  RussianCity(name: 'Бутурлиновка', region: 'Воронежская область', lat: 50.8333, lng: 40.5833),

  // ─── Оренбургская область ───
  RussianCity(name: 'Оренбург', region: 'Оренбургская область', lat: 51.7681, lng: 55.0968),
  RussianCity(name: 'Орск', region: 'Оренбургская область', lat: 51.2333, lng: 58.6167),
  RussianCity(name: 'Новотроицк', region: 'Оренбургская область', lat: 51.2000, lng: 58.3000),
  RussianCity(name: 'Бугуруслан', region: 'Оренбургская область', lat: 53.6167, lng: 52.4333),
  RussianCity(name: 'Бузулук', region: 'Оренбургская область', lat: 52.7667, lng: 52.2667),
  RussianCity(name: 'Гай', region: 'Оренбургская область', lat: 51.4667, lng: 58.4500),
  RussianCity(name: 'Медногорск', region: 'Оренбургская область', lat: 51.4167, lng: 57.5833),
  RussianCity(name: 'Кувандык', region: 'Оренбургская область', lat: 51.4833, lng: 57.3667),
  RussianCity(name: 'Соль-Илецк', region: 'Оренбургская область', lat: 51.1667, lng: 54.9833),
  RussianCity(name: 'Абдулино', region: 'Оренбургская область', lat: 51.6833, lng: 56.3833),

  // ─── Пермский край ───
  RussianCity(name: 'Пермь', region: 'Пермский край', lat: 58.0105, lng: 56.2502),
  RussianCity(name: 'Березники', region: 'Пермский край', lat: 59.4000, lng: 56.7833),
  RussianCity(name: 'Соликамск', region: 'Пермский край', lat: 59.6500, lng: 56.7500),
  RussianCity(name: 'Чайковский', region: 'Пермский край', lat: 56.7667, lng: 54.1500),
  RussianCity(name: 'Кунгур', region: 'Пермский край', lat: 57.4333, lng: 56.9667),
  RussianCity(name: 'Лысьва', region: 'Пермский край', lat: 58.1000, lng: 57.8000),
  RussianCity(name: 'Чусовой', region: 'Пермский край', lat: 58.2833, lng: 57.8167),
  RussianCity(name: 'Горнозаводск', region: 'Пермский край', lat: 58.3667, lng: 58.3167),
  RussianCity(name: 'Добрянка', region: 'Пермский край', lat: 58.4667, lng: 56.4167),
  RussianCity(name: 'Краснокамск', region: 'Пермский край', lat: 58.0833, lng: 55.7500),

  // ─── Саратовская область ───
  RussianCity(name: 'Саратов', region: 'Саратовская область', lat: 51.5336, lng: 46.0342),
  RussianCity(name: 'Энгельс', region: 'Саратовская область', lat: 51.4833, lng: 46.1000),
  RussianCity(name: 'Балашов', region: 'Саратовская область', lat: 51.5500, lng: 43.1667),
  RussianCity(name: 'Балаково', region: 'Саратовская область', lat: 52.0333, lng: 47.8000),
  RussianCity(name: 'Вольск', region: 'Саратовская область', lat: 52.0500, lng: 47.3833),
  RussianCity(name: 'Пугачёв', region: 'Саратовская область', lat: 52.0167, lng: 48.8000),
  RussianCity(name: 'Петровск', region: 'Саратовская область', lat: 52.3000, lng: 45.4000),
  RussianCity(name: 'Маркс', region: 'Саратовская область', lat: 51.7167, lng: 46.7500),
  RussianCity(name: 'Хвалынск', region: 'Саратовская область', lat: 52.4833, lng: 48.1000),

  // ─── Новосибирская область ───
  RussianCity(name: 'Новосибирск', region: 'Новосибирская область', lat: 55.0084, lng: 82.9357),
  RussianCity(name: 'Бердск', region: 'Новосибирская область', lat: 54.7500, lng: 83.1000),
  RussianCity(name: 'Искитим', region: 'Новосибирская область', lat: 54.6333, lng: 83.3000),
  RussianCity(name: 'Татарск', region: 'Новосибирская область', lat: 55.2167, lng: 75.9667),
  RussianCity(name: 'Куйбышев', region: 'Новосибирская область', lat: 55.4500, lng: 78.3167),
  RussianCity(name: 'Барабинск', region: 'Новосибирская область', lat: 55.3500, lng: 78.3500),
  RussianCity(name: 'Карасук', region: 'Новосибирская область', lat: 53.7333, lng: 78.0333),
  RussianCity(name: 'Обь', region: 'Новосибирская область', lat: 55.0167, lng: 82.7167),
  RussianCity(name: 'Черепаново', region: 'Новосибирская область', lat: 54.2167, lng: 83.3833),

  // ─── Красноярский край ───
  RussianCity(name: 'Красноярск', region: 'Красноярский край', lat: 56.0153, lng: 92.8932),
  RussianCity(name: 'Норильск', region: 'Красноярский край', lat: 69.3558, lng: 88.2011),
  RussianCity(name: 'Ачинск', region: 'Красноярский край', lat: 56.2667, lng: 90.5000),
  RussianCity(name: 'Канск', region: 'Красноярский край', lat: 56.2000, lng: 95.7000),
  RussianCity(name: 'Лесосибирск', region: 'Красноярский край', lat: 58.2333, lng: 92.4833),
  RussianCity(name: 'Минусинск', region: 'Красноярский край', lat: 53.7167, lng: 91.6833),
  RussianCity(name: 'Сосновоборск', region: 'Красноярский край', lat: 56.1167, lng: 93.3333),
  RussianCity(name: 'Железногорск', region: 'Красноярский край', lat: 56.3500, lng: 93.5333),
  RussianCity(name: 'Дивногорск', region: 'Красноярский край', lat: 55.9500, lng: 92.3833),

  // ─── Омская область ───
  RussianCity(name: 'Омск', region: 'Омская область', lat: 54.9885, lng: 73.3242),
  RussianCity(name: 'Тара', region: 'Омская область', lat: 56.9000, lng: 74.3833),
  RussianCity(name: 'Тюкалинск', region: 'Омская область', lat: 55.8667, lng: 72.4000),
  RussianCity(name: 'Калачинск', region: 'Омская область', lat: 55.0500, lng: 74.5833),

  // ─── Тюменская область ───
  RussianCity(name: 'Тюмень', region: 'Тюменская область', lat: 57.1522, lng: 65.5550),
  RussianCity(name: 'Тобольск', region: 'Тюменская область', lat: 58.2000, lng: 68.2500),
  RussianCity(name: 'Ялуторовск', region: 'Тюменская область', lat: 56.6500, lng: 66.3167),
  RussianCity(name: 'Заводоуковск', region: 'Тюменская область', lat: 56.5000, lng: 66.7167),

  // ─── Алтайский край ───
  RussianCity(name: 'Барнаул', region: 'Алтайский край', lat: 53.3468, lng: 83.7769),
  RussianCity(name: 'Бийск', region: 'Алтайский край', lat: 52.5500, lng: 85.2167),
  RussianCity(name: 'Рубцовск', region: 'Алтайский край', lat: 51.5000, lng: 81.2333),
  RussianCity(name: 'Заринск', region: 'Алтайский край', lat: 53.9333, lng: 84.9167),
  RussianCity(name: 'Горняк', region: 'Алтайский край', lat: 50.9833, lng: 81.4833),
  RussianCity(name: 'Славгород', region: 'Алтайский край', lat: 52.9833, lng: 78.6333),
  RussianCity(name: 'Алейск', region: 'Алтайский край', lat: 52.4833, lng: 82.7833),

  // ─── Татарстан ───
  RussianCity(name: 'Казань', region: 'Татарстан', lat: 55.7887, lng: 49.1221),
  RussianCity(name: 'Набережные Челны', region: 'Татарстан', lat: 55.7250, lng: 51.8333),
  RussianCity(name: 'Нижнекамск', region: 'Татарстан', lat: 55.6361, lng: 51.8144),
  RussianCity(name: 'Альметьевск', region: 'Татарстан', lat: 54.9000, lng: 52.3000),
  RussianCity(name: 'Зеленодольск', region: 'Татарстан', lat: 55.8500, lng: 48.5000),
  RussianCity(name: 'Бугульма', region: 'Татарстан', lat: 54.5333, lng: 52.7833),
  RussianCity(name: 'Елабуга', region: 'Татарстан', lat: 55.7500, lng: 52.0333),
  RussianCity(name: 'Лениногорск', region: 'Татарстан', lat: 54.6333, lng: 52.4667),
  RussianCity(name: 'Чистополь', region: 'Татарстан', lat: 55.3667, lng: 50.6333),
  RussianCity(name: 'Буинск', region: 'Татарстан', lat: 54.9667, lng: 48.2833),

  // ─── Башкортостан ───
  RussianCity(name: 'Уфа', region: 'Башкортостан', lat: 54.7431, lng: 55.9721),
  RussianCity(name: 'Стерлитамак', region: 'Башкортостан', lat: 53.6667, lng: 55.9667),
  RussianCity(name: 'Салават', region: 'Башкортостан', lat: 53.3333, lng: 55.9333),
  RussianCity(name: 'Нефтекамск', region: 'Башкортостан', lat: 56.0833, lng: 54.2500),
  RussianCity(name: 'Октябрьский', region: 'Башкортостан', lat: 54.4833, lng: 53.4833),
  RussianCity(name: 'Белорецк', region: 'Башкортостан', lat: 53.9667, lng: 58.4000),
  RussianCity(name: 'Кумертау', region: 'Башкортостан', lat: 52.7667, lng: 55.7833),
  RussianCity(name: 'Мелеуз', region: 'Башкортостан', lat: 52.9667, lng: 55.9333),
  RussianCity(name: 'Белебей', region: 'Башкортостан', lat: 54.1000, lng: 54.1000),
  RussianCity(name: 'Давлеканово', region: 'Башкортостан', lat: 54.2167, lng: 55.0333),

  // ─── Дагестан ───
  RussianCity(name: 'Махачкала', region: 'Дагестан', lat: 42.9849, lng: 47.5047),
  RussianCity(name: 'Каспийск', region: 'Дагестан', lat: 42.8900, lng: 47.6300),
  RussianCity(name: 'Дербент', region: 'Дагестан', lat: 42.0578, lng: 48.2900),
  RussianCity(name: 'Хасавюрт', region: 'Дагестан', lat: 43.2500, lng: 46.5833),
  RussianCity(name: 'Буйнакск', region: 'Дагестан', lat: 42.8167, lng: 47.1167),
  RussianCity(name: 'Кизляр', region: 'Дагестан', lat: 43.8500, lng: 46.7333),
  RussianCity(name: 'Избербаш', region: 'Дагестан', lat: 42.5667, lng: 47.8667),
  RussianCity(name: 'Дагестанские Огни', region: 'Дагестан', lat: 42.1167, lng: 47.5833),

  // ─── Чечня ───
  RussianCity(name: 'Грозный', region: 'Чечня', lat: 43.3125, lng: 45.6989),
  RussianCity(name: 'Аргун', region: 'Чечня', lat: 43.3000, lng: 45.8667),
  RussianCity(name: 'Гудермес', region: 'Чечня', lat: 43.3500, lng: 46.1000),
  RussianCity(name: 'Шали', region: 'Чечня', lat: 43.1500, lng: 45.9000),

  // ─── Крым ───
  RussianCity(name: 'Симферополь', region: 'Крым', lat: 44.9521, lng: 34.1024),
  RussianCity(name: 'Севастополь', region: 'Севастополь', lat: 44.6054, lng: 33.5220),
  RussianCity(name: 'Керчь', region: 'Крым', lat: 45.3558, lng: 36.4758),
  RussianCity(name: 'Евпатория', region: 'Крым', lat: 45.1903, lng: 33.3673),
  RussianCity(name: 'Ялта', region: 'Крым', lat: 44.4981, lng: 34.1665),
  RussianCity(name: 'Феодосия', region: 'Крым', lat: 45.0339, lng: 35.3778),
  RussianCity(name: 'Бахчисарай', region: 'Крым', lat: 44.7553, lng: 33.8600),
  RussianCity(name: 'Джанкой', region: 'Крым', lat: 45.7103, lng: 34.3919),
  RussianCity(name: 'Красноперекопск', region: 'Крым', lat: 45.9561, lng: 33.7936),
  RussianCity(name: 'Алушта', region: 'Крым', lat: 44.6772, lng: 34.4089),

  // ─── Иркутская область ───
  RussianCity(name: 'Иркутск', region: 'Иркутская область', lat: 52.2978, lng: 104.2964),
  RussianCity(name: 'Братск', region: 'Иркутская область', lat: 56.1500, lng: 101.6333),
  RussianCity(name: 'Усть-Илимск', region: 'Иркутская область', lat: 58.0000, lng: 102.6667),
  RussianCity(name: 'Ангарск', region: 'Иркутская область', lat: 52.5333, lng: 103.8833),
  RussianCity(name: 'Усолье-Сибирское', region: 'Иркутская область', lat: 52.7500, lng: 103.6500),
  RussianCity(name: 'Шелехов', region: 'Иркутская область', lat: 52.2000, lng: 104.1000),
  RussianCity(name: 'Тулун', region: 'Иркутская область', lat: 54.5667, lng: 100.5833),
  RussianCity(name: 'Зима', region: 'Иркутская область', lat: 53.9167, lng: 102.0333),

  // ─── Хабаровский край ───
  RussianCity(name: 'Хабаровск', region: 'Хабаровский край', lat: 48.4827, lng: 135.0837),
  RussianCity(name: 'Комсомольск-на-Амуре', region: 'Хабаровский край', lat: 50.5500, lng: 137.0000),
  RussianCity(name: 'Амурск', region: 'Хабаровский край', lat: 48.6333, lng: 135.2667),
  RussianCity(name: 'Советская Гавань', region: 'Хабаровский край', lat: 48.9667, lng: 140.3000),
  RussianCity(name: 'Николаевск-на-Амуре', region: 'Хабаровский край', lat: 53.1500, lng: 140.7333),

  // ─── Приморский край ───
  RussianCity(name: 'Владивосток', region: 'Приморский край', lat: 43.1155, lng: 131.8855),
  RussianCity(name: 'Находка', region: 'Приморский край', lat: 42.8333, lng: 132.8833),
  RussianCity(name: 'Уссурийск', region: 'Приморский край', lat: 43.2000, lng: 131.9000),
  RussianCity(name: 'Дальнереченск', region: 'Приморский край', lat: 45.9333, lng: 133.7333),
  RussianCity(name: 'Арсеньев', region: 'Приморский край', lat: 43.1667, lng: 133.2500),
  RussianCity(name: 'Спасск-Дальний', region: 'Приморский край', lat: 44.6000, lng: 132.8167),
  RussianCity(name: 'Партизанск', region: 'Приморский край', lat: 43.3500, lng: 133.1333),

  // ─── Волгоградская область ───
  RussianCity(name: 'Камышлов', region: 'Волгоградская область', lat: 50.0667, lng: 45.4000),
  RussianCity(name: 'Городище', region: 'Волгоградская область', lat: 48.8000, lng: 44.2333),
  RussianCity(name: 'Дубовка', region: 'Волгоградская область', lat: 49.0500, lng: 44.8333),

  // ─── Ростовская область ───
  RussianCity(name: 'Новoshakhtinsk', region: 'Ростовская область', lat: 47.7500, lng: 39.9333),
  RussianCity(name: 'Зерноград', region: 'Ростовская область', lat: 46.8500, lng: 40.3000),
  RussianCity(name: 'Цимлянск', region: 'Ростовская область', lat: 47.6500, lng: 42.1000),
  RussianCity(name: 'Константиновск', region: 'Ростовская область', lat: 47.5833, lng: 41.1000),
  RussianCity(name: 'Морозовск', region: 'Ростовская область', lat: 48.3500, lng: 41.8333),
  RussianCity(name: 'Егорлыкская', region: 'Ростовская область', lat: 46.5667, lng: 40.6667),

  // ─── Свердловская область ───
  RussianCity(name: 'Нижняя Салда', region: 'Свердловская область', lat: 58.0500, lng: 60.7167),
  RussianCity(name: 'Верхняя Салда', region: 'Свердловская область', lat: 58.0333, lng: 60.5667),
  RussianCity(name: 'Артёмовский', region: 'Свердловская область', lat: 57.3500, lng: 61.9000),
  RussianCity(name: 'Талда', region: 'Свердловская область', lat: 57.1333, lng: 63.7333),
  RussianCity(name: 'Тавда', region: 'Свердловская область', lat: 58.0500, lng: 65.2667),
  RussianCity(name: 'Туринск', region: 'Свердловская область', lat: 58.0500, lng: 63.7000),

  // ─── Челябинская область ───
  RussianCity(name: 'Аргаяш', region: 'Челябинская область', lat: 55.4000, lng: 60.8333),
  RussianCity(name: 'Куса', region: 'Челябинская область', lat: 55.3333, lng: 59.4333),
  RussianCity(name: 'Нязепетровск', region: 'Челябинская область', lat: 56.0500, lng: 59.6000),

  // ─── Самарская область ───
  RussianCity(name: 'Нефтегорск', region: 'Самарская область', lat: 52.8000, lng: 51.1667),
  RussianCity(name: 'Безенчук', region: 'Самарская область', lat: 53.0000, lng: 49.4667),

  // ─── Нижегородская область ───
  RussianCity(name: 'Выкса', region: 'Нижегородская область', lat: 55.3167, lng: 42.1667),
  RussianCity(name: 'Навашино', region: 'Нижегородская область', lat: 55.5500, lng: 42.2000),
  RussianCity(name: 'Городец', region: 'Нижегородская область', lat: 56.6500, lng: 43.4833),
  RussianCity(name: 'Чкаловск', region: 'Нижегородская область', lat: 56.7667, lng: 43.2500),
  RussianCity(name: 'Кулебаки', region: 'Нижегородская область', lat: 55.4500, lng: 42.5167),
  RussianCity(name: 'Шахунья', region: 'Нижегородская область', lat: 57.6667, lng: 46.6167),

  // ─── Омская область ───
  RussianCity(name: 'Муромцево', region: 'Омская область', lat: 56.3833, lng: 75.2167),

  // ─── Тюменская область ───
  RussianCity(name: 'Ишим', region: 'Тюменская область', lat: 56.1167, lng: 69.5000),
  RussianCity(name: 'Викулово', region: 'Тюменская область', lat: 56.8167, lng: 70.6167),

  // ─── Алтайский край ───
  RussianCity(name: 'Рефтинский', region: 'Алтайский край', lat: 53.0667, lng: 83.6333),

  // ─── Красноярский край ───
  RussianCity(name: 'Ужур', region: 'Красноярский край', lat: 55.3167, lng: 89.8333),

  // ─── Калининградская область ───
  RussianCity(name: 'Калининград', region: 'Калининградская область', lat: 54.7104, lng: 20.4522),
  RussianCity(name: 'Советск', region: 'Калининградская область', lat: 55.0833, lng: 21.8833),
  RussianCity(name: 'Черняховск', region: 'Калининградская область', lat: 54.6000, lng: 21.7167),
  RussianCity(name: 'Балтийск', region: 'Калининградская область', lat: 54.6500, lng: 19.9167),
  RussianCity(name: 'Гурьевск', region: 'Калининградская область', lat: 54.7667, lng: 20.6000),

  // ─── Кемеровская область ───
  RussianCity(name: 'Кемерово', region: 'Кемеровская область', lat: 55.3333, lng: 86.0833),
  RussianCity(name: 'Новокузнецк', region: 'Кемеровская область', lat: 53.7500, lng: 87.1167),
  RussianCity(name: 'Прокопьевск', region: 'Кемеровская область', lat: 53.8833, lng: 86.7167),
  RussianCity(name: 'Междуреченск', region: 'Кемеровская область', lat: 53.6833, lng: 88.0500),
  RussianCity(name: 'Белово', region: 'Кемеровская область', lat: 54.4167, lng: 86.3000),
  RussianCity(name: 'Гурьевск', region: 'Кемеровская область', lat: 54.2833, lng: 85.9333),
  RussianCity(name: 'Киселёвск', region: 'Кемеровская область', lat: 54.0000, lng: 86.6333),
  RussianCity(name: 'Ленинск-Кузнецкий', region: 'Кемеровская область', lat: 54.6667, lng: 86.1667),

  // ─── Томская область ───
  RussianCity(name: 'Томск', region: 'Томская область', lat: 56.4977, lng: 84.9744),
  RussianCity(name: 'Северск', region: 'Томская область', lat: 56.6000, lng: 84.8500),
  RussianCity(name: 'Колпашево', region: 'Томская область', lat: 58.3167, lng: 82.9333),

  // ─── Курганская область ───
  RussianCity(name: 'Курган', region: 'Курганская область', lat: 55.4408, lng: 65.3411),
  RussianCity(name: 'Шадринск', region: 'Курганская область', lat: 56.0833, lng: 63.6333),
  RussianCity(name: 'Катайск', region: 'Курганская область', lat: 56.3000, lng: 64.1167),

  // ─── Читинская область / Забайкальский край ───
  RussianCity(name: 'Чита', region: 'Забайкальский край', lat: 52.0333, lng: 113.5000),
  RussianCity(name: 'Борзя', region: 'Забайкальский край', lat: 50.3833, lng: 116.5167),
  RussianCity(name: 'Краснокаменск', region: 'Забайкальский край', lat: 50.1000, lng: 118.0333),
  RussianCity(name: 'Могоча', region: 'Забайкальский край', lat: 53.7333, lng: 119.7667),

  // ─── Амурская область ───
  RussianCity(name: 'Благовещенск', region: 'Амурская область', lat: 50.2722, lng: 127.5406),
  RussianCity(name: 'Белогорск', region: 'Амурская область', lat: 50.9333, lng: 128.4667),
  RussianCity(name: 'Свободный', region: 'Амурская область', lat: 51.3833, lng: 128.1333),
  RussianCity(name: 'Зея', region: 'Амурская область', lat: 53.9333, lng: 127.2667),

  // ─── Сахалинская область ───
  RussianCity(name: 'Южно-Сахалинск', region: 'Сахалинская область', lat: 46.9589, lng: 142.7386),
  RussianCity(name: 'Корсаков', region: 'Сахалинская область', lat: 46.6333, lng: 142.7667),
  RussianCity(name: 'Холмск', region: 'Сахалинская область', lat: 47.0500, lng: 142.0500),
  RussianCity(name: 'Долинск', region: 'Сахалинская область', lat: 47.3333, lng: 142.8000),

  // ─── Камчатский край ───
  RussianCity(name: 'Петропавловск-Камчатский', region: 'Камчатский край', lat: 53.0131, lng: 158.6483),
  RussianCity(name: 'Елизово', region: 'Камчатский край', lat: 53.1833, lng: 158.3833),
  RussianCity(name: 'Ключи', region: 'Камчатский край', lat: 56.3167, lng: 160.8333),

  // ─── Магаданская область ───
  RussianCity(name: 'Магадан', region: 'Магаданская область', lat: 59.5683, lng: 150.8000),
  RussianCity(name: 'Сусуман', region: 'Магаданская область', lat: 62.7833, lng: 148.1667),

  // ─── ЯНАО ───
  RussianCity(name: 'Салехард', region: 'ЯНАО', lat: 66.5298, lng: 66.6036),
  RussianCity(name: 'Надым', region: 'ЯНАО', lat: 65.4833, lng: 72.5333),
  RussianCity(name: 'Ноябрьск', region: 'ЯНАО', lat: 63.2000, lng: 75.4500),
  RussianCity(name: 'Нижневартовск', region: 'ЯНАО', lat: 60.9333, lng: 76.5667),
  RussianCity(name: 'Муравленко', region: 'ЯНАО', lat: 63.7833, lng: 74.5333),

  // ─── ХМАО ───
  RussianCity(name: 'Ханты-Мансийск', region: 'ХМАО', lat: 61.0000, lng: 69.0333),
  RussianCity(name: 'Сургут', region: 'ХМАО', lat: 61.2500, lng: 73.4000),
  RussianCity(name: 'Нижневартовск', region: 'ХМАО', lat: 60.9333, lng: 76.5667),
  RussianCity(name: 'Нефтеюганск', region: 'ХМАО', lat: 61.0833, lng: 72.6167),
  RussianCity(name: 'Когалым', region: 'ХМАО', lat: 62.2667, lng: 74.4833),
  RussianCity(name: 'Лангепас', region: 'ХМАО', lat: 61.2500, lng: 75.1667),
  RussianCity(name: 'Радужный', region: 'ХМАО', lat: 62.1333, lng: 77.4667),

  // ─── Мурманская область ───
  RussianCity(name: 'Мурманск', region: 'Мурманская область', lat: 68.9585, lng: 33.0827),
  RussianCity(name: 'Апатиты', region: 'Мурманская область', lat: 67.4667, lng: 33.4000),
  RussianCity(name: 'Кировск', region: 'Мурманская область', lat: 67.6167, lng: 33.6500),
  RussianCity(name: 'Полярные Зори', region: 'Мурманская область', lat: 67.3667, lng: 32.5000),
  RussianCity(name: 'Оленегорск', region: 'Мурманская область', lat: 68.1500, lng: 33.2667),
  RussianCity(name: 'Кандалакша', region: 'Мурманская область', lat: 67.2333, lng: 32.4167),
  RussianCity(name: 'Североморск', region: 'Мурманская область', lat: 69.0667, lng: 33.4167),

  // ─── Архангельская область ───
  RussianCity(name: 'Архангельск', region: 'Архангельская область', lat: 64.5399, lng: 40.5152),
  RussianCity(name: 'Северодвинск', region: 'Архангельская область', lat: 64.5635, lng: 39.8302),
  RussianCity(name: 'Котлас', region: 'Архангельская область', lat: 61.2500, lng: 46.6500),
  RussianCity(name: 'Вельск', region: 'Архангельская область', lat: 61.0000, lng: 42.1000),
  RussianCity(name: 'Виноградов', region: 'Архангельская область', lat: 62.8333, lng: 45.7500),

  // ─── Вологодская область ───
  RussianCity(name: 'Вологда', region: 'Вологодская область', lat: 59.2205, lng: 39.8915),
  RussianCity(name: 'Череповец', region: 'Вологодская область', lat: 59.1333, lng: 37.9167),
  RussianCity(name: 'Сокол', region: 'Вологодская область', lat: 59.4667, lng: 39.9000),
  RussianCity(name: 'Великий Устюг', region: 'Вологодская область', lat: 60.7583, lng: 46.3167),
  RussianCity(name: 'Котлас', region: 'Вологодская область', lat: 61.2500, lng: 46.6500),

  // ─── Новгородская область ───
  RussianCity(name: 'Великий Новгород', region: 'Новгородская область', lat: 58.5217, lng: 31.2756),
  RussianCity(name: 'Боровичи', region: 'Новгородская область', lat: 58.3833, lng: 33.8833),
  RussianCity(name: 'Старая Русса', region: 'Новгородская область', lat: 57.9833, lng: 31.3667),
  RussianCity(name: 'Малая Вишера', region: 'Новгородская область', lat: 58.8500, lng: 32.2167),

  // ─── Псковская область ───
  RussianCity(name: 'Псков', region: 'Псковская область', lat: 57.8136, lng: 28.3496),
  RussianCity(name: 'Великие Луки', region: 'Псковская область', lat: 56.3500, lng: 30.5500),
  RussianCity(name: 'Остров', region: 'Псковская область', lat: 57.3333, lng: 28.3500),
  RussianCity(name: 'Порхов', region: 'Псковская область', lat: 57.4500, lng: 29.3833),
  RussianCity(name: 'Печоры', region: 'Псковская область', lat: 57.8167, lng: 27.6000),

  // ─── Брянская область ───
  RussianCity(name: 'Брянск', region: 'Брянская область', lat: 53.2521, lng: 34.3717),
  RussianCity(name: 'Курчатов', region: 'Брянская область', lat: 51.6667, lng: 35.6500),
  RussianCity(name: 'Новозыбков', region: 'Брянская область', lat: 52.5333, lng: 31.9333),
  RussianCity(name: 'Дятьково', region: 'Брянская область', lat: 53.5833, lng: 34.3333),
  RussianCity(name: 'Белыничи', region: 'Брянская область', lat: 53.0667, lng: 33.6667),

  // ─── Калужская область ───
  RussianCity(name: 'Калуга', region: 'Калужская область', lat: 54.5147, lng: 36.2708),
  RussianCity(name: 'Обнинск', region: 'Калужская область', lat: 55.1000, lng: 36.6167),
  RussianCity(name: 'Людиново', region: 'Калужская область', lat: 53.8667, lng: 34.4667),
  RussianCity(name: 'Козельск', region: 'Калужская область', lat: 54.0333, lng: 35.7833),
  RussianCity(name: 'Малоярославец', region: 'Калужская область', lat: 54.9167, lng: 36.4833),

  // ─── Тульская область ───
  RussianCity(name: 'Тула', region: 'Тульская область', lat: 54.1939, lng: 37.6178),
  RussianCity(name: 'Новомосковск', region: 'Тульская область', lat: 54.0833, lng: 38.2667),
  RussianCity(name: 'Донской', region: 'Тульская область', lat: 54.0000, lng: 38.3333),
  RussianCity(name: 'Узловая', region: 'Тульская область', lat: 53.9833, lng: 38.1667),
  RussianCity(name: 'Ефремов', region: 'Тульская область', lat: 53.1500, lng: 38.1000),
  RussianCity(name: 'Суворов', region: 'Тульская область', lat: 54.1167, lng: 36.4833),

  // ─── Рязанская область ───
  RussianCity(name: 'Рязань', region: 'Рязанская область', lat: 54.6296, lng: 39.6911),
  RussianCity(name: 'Касимов', region: 'Рязанская область', lat: 54.9333, lng: 41.3833),
  RussianCity(name: 'Ряжск', region: 'Рязанская область', lat: 53.7000, lng: 40.0500),
  RussianCity(name: 'Михайлов', region: 'Рязанская область', lat: 54.2333, lng: 39.0333),
  RussianCity(name: 'Скопин', region: 'Рязанская область', lat: 53.8167, lng: 39.5333),

  // ─── Тамбовская область ───
  RussianCity(name: 'Тамбов', region: 'Тамбовская область', lat: 52.7214, lng: 41.4174),
  RussianCity(name: 'Мичуринск', region: 'Тамбовская область', lat: 52.9000, lng: 41.7500),
  RussianCity(name: 'Кирсанов', region: 'Тамбовская область', lat: 52.6500, lng: 42.7333),
  RussianCity(name: 'Моршанск', region: 'Тамбовская область', lat: 53.4500, lng: 41.8000),
  RussianCity(name: 'Уварово', region: 'Тамбовская область', lat: 51.9833, lng: 42.2667),

  // ─── Липецкая область ───
  RussianCity(name: 'Липецк', region: 'Липецкая область', lat: 52.6052, lng: 39.5727),
  RussianCity(name: 'Елец', region: 'Липецкая область', lat: 52.6167, lng: 38.5000),
  RussianCity(name: 'Грязи', region: 'Липецкая область', lat: 52.4833, lng: 39.9333),
  RussianCity(name: 'Усмань', region: 'Липецкая область', lat: 52.0500, lng: 39.7333),
  RussianCity(name: 'Данков', region: 'Липецкая область', lat: 53.2500, lng: 39.1333),

  // ─── Пензенская область ───
  RussianCity(name: 'Пенза', region: 'Пензенская область', lat: 53.1959, lng: 45.0178),
  RussianCity(name: 'Кузнецк', region: 'Пензенская область', lat: 53.1167, lng: 46.5833),
  RussianCity(name: 'Сердобск', region: 'Пензенская область', lat: 52.4667, lng: 44.2167),
  RussianCity(name: 'Нерчинск', region: 'Пензенская область', lat: 52.9000, lng: 45.1833),
  RussianCity(name: 'Заречный', region: 'Пензенская область', lat: 53.2000, lng: 45.1667),

  // ─── Ульяновская область ───
  RussianCity(name: 'Ульяновск', region: 'Ульяновская область', lat: 54.3000, lng: 48.3500),
  RussianCity(name: 'Димитровград', region: 'Ульяновская область', lat: 54.2167, lng: 49.6167),
  RussianCity(name: 'Новоспасское', region: 'Ульяновская область', lat: 54.6333, lng: 48.3667),
  RussianCity(name: 'Инза', region: 'Ульяновская область', lat: 54.0500, lng: 46.3333),

  // ─── Чувашская Республика ───
  RussianCity(name: 'Чебоксары', region: 'Чувашская Республика', lat: 56.1322, lng: 47.2519),
  RussianCity(name: 'Новочебоксарск', region: 'Чувашская Республика', lat: 56.1167, lng: 47.4833),
  RussianCity(name: 'Канаш', region: 'Чувашская Республика', lat: 55.5000, lng: 47.4833),
  RussianCity(name: 'Шумерля', region: 'Чувашская Республика', lat: 55.5000, lng: 46.4500),

  // ─── Мордовия ───
  RussianCity(name: 'Саранск', region: 'Мордовия', lat: 54.1833, lng: 45.1833),
  RussianCity(name: 'Рузаевка', region: 'Мордовия', lat: 54.0500, lng: 44.9500),
  RussianCity(name: 'Ковылкино', region: 'Мордовия', lat: 54.0333, lng: 43.9167),

  // ─── Мари Эл ───
  RussianCity(name: 'Йошкар-Ола', region: 'Мари Эл', lat: 56.6328, lng: 47.8958),
  RussianCity(name: 'Козьмодемьянск', region: 'Мари Эл', lat: 56.3417, lng: 46.5750),

  // ─── Удмуртия ───
  RussianCity(name: 'Ижевск', region: 'Удмуртия', lat: 56.8525, lng: 53.2338),
  RussianCity(name: 'Сарапул', region: 'Удмуртия', lat: 56.4733, lng: 53.8033),
  RussianCity(name: 'Воткинск', region: 'Удмуртия', lat: 57.0500, lng: 53.9833),
  RussianCity(name: 'Глазов', region: 'Удмуртия', lat: 58.1333, lng: 52.6667),
  RussianCity(name: 'Можга', region: 'Удмуртия', lat: 56.4500, lng: 52.2167),

  // ─── Коми ───
  RussianCity(name: 'Сыктывкар', region: 'Коми', lat: 61.6688, lng: 50.8364),
  RussianCity(name: 'Ухта', region: 'Коми', lat: 63.5667, lng: 53.7000),
  RussianCity(name: 'Воркута', region: 'Коми', lat: 67.5000, lng: 64.0333),
  RussianCity(name: 'Печора', region: 'Коми', lat: 65.0833, lng: 57.2167),
  RussianCity(name: 'Усинск', region: 'Коми', lat: 66.0000, lng: 57.5333),

  // ─── Тверская область ───
  RussianCity(name: 'Тверь', region: 'Тверская область', lat: 56.8587, lng: 35.9176),
  RussianCity(name: 'Ржев', region: 'Тверская область', lat: 56.2500, lng: 34.3333),
  RussianCity(name: 'Вышний Волочёк', region: 'Тверская область', lat: 57.5833, lng: 34.5667),
  RussianCity(name: 'Торжок', region: 'Тверская область', lat: 56.9167, lng: 34.9667),
  RussianCity(name: 'Кимры', region: 'Тверская область', lat: 56.8667, lng: 37.3500),
  RussianCity(name: 'Конаково', region: 'Тверская область', lat: 56.7500, lng: 36.7833),
  RussianCity(name: 'Удомля', region: 'Тверская область', lat: 57.8833, lng: 35.0833),

  // ─── Ярославская область ───
  RussianCity(name: 'Ярославль', region: 'Ярославская область', lat: 57.6261, lng: 39.8736),
  RussianCity(name: 'Рыбинск', region: 'Ярославская область', lat: 58.0500, lng: 38.8333),
  RussianCity(name: 'Переславль-Залесский', region: 'Ярославская область', lat: 56.7333, lng: 38.8500),
  RussianCity(name: 'Углич', region: 'Ярославская область', lat: 57.5333, lng: 38.3333),
  RussianCity(name: 'Тутаев', region: 'Ярославская область', lat: 57.8833, lng: 39.5333),
  RussianCity(name: 'Гаврилов-Ям', region: 'Ярославская область', lat: 57.3000, lng: 39.8333),

  // ─── Ивановская область ───
  RussianCity(name: 'Иваново', region: 'Ивановская область', lat: 57.0040, lng: 40.9842),
  RussianCity(name: 'Кинешма', region: 'Ивановская область', lat: 57.4500, lng: 42.1333),
  RussianCity(name: 'Шуя', region: 'Ивановская область', lat: 56.8500, lng: 41.3833),
  RussianCity(name: 'Фурманов', region: 'Ивановская область', lat: 57.2500, lng: 41.1000),

  // ─── Владимирская область ───
  RussianCity(name: 'Владимир', region: 'Владимирская область', lat: 56.1290, lng: 40.4068),
  RussianCity(name: 'Ковров', region: 'Владимирская область', lat: 56.3572, lng: 41.3233),
  RussianCity(name: 'Муром', region: 'Владимирская область', lat: 55.5725, lng: 41.7953),
  RussianCity(name: 'Александров', region: 'Владимирская область', lat: 56.3833, lng: 38.4500),
  RussianCity(name: 'Гусь-Хрустальный', region: 'Владимирская область', lat: 55.6200, lng: 40.6500),
  RussianCity(name: 'Кольчугино', region: 'Владимирская область', lat: 56.3000, lng: 39.3833),
  RussianCity(name: 'Заречный', region: 'Владимирская область', lat: 56.3500, lng: 40.2833),

  // ─── Орловская область ───
  RussianCity(name: 'Орёл', region: 'Орловская область', lat: 52.9672, lng: 36.0694),
  RussianCity(name: 'Ливны', region: 'Орловская область', lat: 52.4333, lng: 37.6000),
  RussianCity(name: 'Мценск', region: 'Орловская область', lat: 53.2667, lng: 36.5667),
  RussianCity(name: 'Болхов', region: 'Орловская область', lat: 53.4333, lng: 36.0000),

  // ─── Курская область ───
  RussianCity(name: 'Курск', region: 'Курская область', lat: 51.7372, lng: 36.1872),
  RussianCity(name: 'Железногорск', region: 'Курская область', lat: 52.3333, lng: 35.3500),
  RussianCity(name: 'Курчатов', region: 'Курская область', lat: 51.6667, lng: 35.6500),
  RussianCity(name: 'Льгов', region: 'Курская область', lat: 51.6333, lng: 35.2667),
  RussianCity(name: 'Рыльск', region: 'Курская область', lat: 51.5667, lng: 34.6833),
  RussianCity(name: 'Обоянь', region: 'Курская область', lat: 51.2167, lng: 36.2667),

  // ─── Белгородская область ───
  RussianCity(name: 'Белгород', region: 'Белгородская область', lat: 50.6035, lng: 36.5836),
  RussianCity(name: 'Старый Оскол', region: 'Белгородская область', lat: 51.3000, lng: 37.8333),
  RussianCity(name: 'Губкин', region: 'Белгородская область', lat: 51.2833, lng: 37.5000),
  RussianCity(name: 'Бирюч', region: 'Белгородская область', lat: 50.6500, lng: 38.4000),
  RussianCity(name: 'Алексеевка', region: 'Белгородская область', lat: 50.6333, lng: 38.6833),

  // ─── Липецкая область (extra) ───
  RussianCity(name: 'Воронеж', region: 'Липецкая область', lat: 52.6052, lng: 39.5727),

  // ─── Смоленская область ───
  RussianCity(name: 'Смоленск', region: 'Смоленская область', lat: 54.7826, lng: 32.0453),
  RussianCity(name: 'Рославль', region: 'Смоленская область', lat: 53.7500, lng: 32.8667),
  RussianCity(name: 'Ярцево', region: 'Смоленская область', lat: 55.0500, lng: 32.6833),
  RussianCity(name: 'Сафоново', region: 'Смоленская область', lat: 55.1833, lng: 33.2500),
  RussianCity(name: 'Вязьма', region: 'Смоленская область', lat: 55.2167, lng: 34.2833),
  RussianCity(name: 'Гагарин', region: 'Смоленская область', lat: 55.5500, lng: 35.0000),

  // ─── Костромская область ───
  RussianCity(name: 'Кострома', region: 'Костромская область', lat: 57.7667, lng: 40.9333),
  RussianCity(name: 'Шарья', region: 'Костромская область', lat: 58.3667, lng: 45.5167),
  RussianCity(name: 'Буя', region: 'Костромская область', lat: 58.4833, lng: 41.5667),
  RussianCity(name: 'Мантурово', region: 'Костромская область', lat: 58.3333, lng: 44.7500),
  RussianCity(name: 'Нерехта', region: 'Костромская область', lat: 57.4500, lng: 40.5833),

  // ─── Кировская область ───
  RussianCity(name: 'Киров', region: 'Кировская область', lat: 58.6035, lng: 49.6680),
  RussianCity(name: 'Кирово-Чепецк', region: 'Кировская область', lat: 58.5500, lng: 50.0333),
  RussianCity(name: 'Слободской', region: 'Кировская область', lat: 58.7333, lng: 50.1667),
  RussianCity(name: 'Белая Холуница', region: 'Кировская область', lat: 58.8333, lng: 50.8500),

  // ─── Астраханская область ───
  RussianCity(name: 'Астрахань', region: 'Астраханская область', lat: 46.3498, lng: 48.0408),
  RussianCity(name: 'Камызяк', region: 'Астраханская область', lat: 46.1167, lng: 48.0667),
  RussianCity(name: 'Харабали', region: 'Астраханская область', lat: 47.4000, lng: 47.2500),

  // ─── Омская (extra) ───
  RussianCity(name: 'Ишим', region: 'Омская область', lat: 56.1167, lng: 69.5000),

  // ─── Курганская (extra) ───
  RussianCity(name: 'Шумиха', region: 'Курганская область', lat: 55.2333, lng: 63.2833),
  RussianCity(name: 'Макушино', region: 'Курганская область', lat: 55.2000, lng: 67.2500),

  // ─── Сахалинская (extra) ───
  RussianCity(name: 'Александровск-Сахалинский', region: 'Сахалинская область', lat: 50.9000, lng: 142.1667),
  RussianCity(name: 'Кусаган', region: 'Сахалинская область', lat: 46.6333, lng: 143.3333),

  // ─── Еврейская автономная ───
  RussianCity(name: 'Биробиджан', region: 'ЕАО', lat: 48.7928, lng: 132.9214),
  RussianCity(name: 'Облучье', region: 'ЕАО', lat: 49.0167, lng: 131.0833),

  // ─── Ненецкий АО ───
  RussianCity(name: 'Нарьян-Мар', region: 'НАО', lat: 67.6381, lng: 53.0069),

  // ─── Чукотка ───
  RussianCity(name: 'Анадырь', region: 'Чукотка', lat: 64.7333, lng: 177.5000),

  // ─── Алтай (Республика) ───
  RussianCity(name: 'Горно-Алтайск', region: 'Алтай', lat: 51.9583, lng: 85.9558),
  RussianCity(name: 'Майма', region: 'Алтай', lat: 51.8167, lng: 85.9833),

  // ─── Тыва ───
  RussianCity(name: 'Кызыл', region: 'Тыва', lat: 51.7167, lng: 94.4500),
  RussianCity(name: 'Ак-Довурак', region: 'Тыва', lat: 51.2833, lng: 90.6000),

  // ─── Хакасия ───
  RussianCity(name: 'Абакан', region: 'Хакасия', lat: 53.7208, lng: 91.4414),
  RussianCity(name: 'Саяногорск', region: 'Хакасия', lat: 53.1500, lng: 91.4833),
  RussianCity(name: 'Черногорск', region: 'Хакасия', lat: 53.8167, lng: 91.3000),

  // ─── Калмыкия ───
  RussianCity(name: 'Элиста', region: 'Калмыкия', lat: 46.3083, lng: 44.2558),
  RussianCity(name: 'Городовиковск', region: 'Калмыкия', lat: 46.1000, lng: 41.9333),

  // ─── Кабардино-Балкария ───
  RussianCity(name: 'Нальчик', region: 'Кабардино-Балкария', lat: 43.4846, lng: 43.6072),
  RussianCity(name: 'Прохладный', region: 'Кабардино-Балкария', lat: 43.7567, lng: 44.0106),
  RussianCity(name: 'Баксан', region: 'Кабардино-Балкария', lat: 43.6833, lng: 43.5333),
  RussianCity(name: 'Нарткала', region: 'Кабардино-Балкария', lat: 43.5500, lng: 43.8500),

  // ─── Северная Осетия ───
  RussianCity(name: 'Владикавказ', region: 'Северная Осетия', lat: 43.0205, lng: 44.6820),
  RussianCity(name: 'Беслан', region: 'Северная Осетия', lat: 43.1833, lng: 44.5333),
  RussianCity(name: 'Моздок', region: 'Северная Осетия', lat: 43.7333, lng: 44.6500),

  // ─── Ингушетия ───
  RussianCity(name: 'Магас', region: 'Ингушетия', lat: 43.2264, lng: 44.7639),
  RussianCity(name: 'Назрань', region: 'Ингушетия', lat: 43.2264, lng: 44.7639),
  RussianCity(name: 'Карабулак', region: 'Ингушетия', lat: 43.3000, lng: 44.9000),

  // ─── Бурятия ───
  RussianCity(name: 'Улан-Удэ', region: 'Бурятия', lat: 51.8333, lng: 107.5833),
  RussianCity(name: 'Северобайкальск', region: 'Бурятия', lat: 55.6333, lng: 109.3167),
  RussianCity(name: 'Гусиноозёрск', region: 'Бурятия', lat: 51.2833, lng: 106.5000),

  // ─── Карелия ───
  RussianCity(name: 'Петрозаводск', region: 'Карелия', lat: 61.7969, lng: 34.3589),
  RussianCity(name: 'Кондопога', region: 'Карелия', lat: 62.2000, lng: 34.2667),
  RussianCity(name: 'Сегежа', region: 'Карелия', lat: 63.7333, lng: 34.3167),
  RussianCity(name: 'Костомукша', region: 'Карелия', lat: 64.5833, lng: 30.7667),

  // ─── Новосибирская (extra) ───
  RussianCity(name: 'Краснообск', region: 'Новосибирская область', lat: 55.0167, lng: 82.9333),
  RussianCity(name: 'Кольцово', region: 'Новосибирская область', lat: 54.9500, lng: 83.1833),

  // ─── Волгоградская (extra) ───
  RussianCity(name: 'Кумылженская', region: 'Волгоградская область', lat: 49.9000, lng: 42.6000),
];
