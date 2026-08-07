class RussianStreet {
  final String city;
  final String street;
  final double lat;
  final double lng;

  const RussianStreet({
    required this.city,
    required this.street,
    required this.lat,
    required this.lng,
  });
}

const List<RussianStreet> russianStreets = [
  // ─── Москва ───
  RussianStreet(city: 'Москва', street: 'Тверская', lat: 55.7644, lng: 37.6053),
  RussianStreet(city: 'Москва', street: 'Арбат', lat: 55.7520, lng: 37.5939),
  RussianStreet(city: 'Москва', street: 'Ленинградский проспект', lat: 55.7720, lng: 37.5940),
  RussianStreet(city: 'Москва', street: 'Кутузовский проспект', lat: 55.7410, lng: 37.5620),
  RussianStreet(city: 'Москва', street: 'Ленинский проспект', lat: 55.7070, lng: 37.5870),
  RussianStreet(city: 'Москва', street: 'Курская', lat: 55.7570, lng: 37.6580),
  RussianStreet(city: 'Москва', street: 'Садовая-Кудринская', lat: 55.7690, lng: 37.5860),
  RussianStreet(city: 'Москва', street: 'Новый Арбат', lat: 55.7570, lng: 37.5990),
  RussianStreet(city: 'Москва', street: 'Сретенка', lat: 55.7650, lng: 37.6370),
  RussianStreet(city: 'Москва', street: 'Мясницкая', lat: 55.7610, lng: 37.6390),
  RussianStreet(city: 'Москва', street: 'Покровка', lat: 55.7590, lng: 37.6520),
  RussianStreet(city: 'Москва', street: 'Маросейка', lat: 55.7580, lng: 37.6490),
  RussianStreet(city: 'Москва', street: 'Большая Дмитровка', lat: 55.7620, lng: 37.6130),
  RussianStreet(city: 'Москва', street: 'Никольская', lat: 55.7580, lng: 37.6270),
  RussianStreet(city: 'Москва', street: 'Варварка', lat: 55.7520, lng: 37.6290),
  RussianStreet(city: 'Москва', street: 'Малая Якиманка', lat: 55.7440, lng: 37.6140),
  RussianStreet(city: 'Москва', street: 'Большая Якиманка', lat: 55.7420, lng: 37.6110),
  RussianStreet(city: 'Москва', street: 'Пречистенка', lat: 55.7390, lng: 37.5980),
  RussianStreet(city: 'Москва', street: 'Волхонка', lat: 55.7430, lng: 37.6040),
  RussianStreet(city: 'Москва', street: 'Знаменка', lat: 55.7480, lng: 37.5980),
  RussianStreet(city: 'Москва', street: 'Львовская', lat: 55.7680, lng: 37.5820),
  RussianStreet(city: 'Москва', street: 'Плющиха', lat: 55.7480, lng: 37.5750),
  RussianStreet(city: 'Москва', street: 'Патриаршие пруды', lat: 55.7700, lng: 37.5780),
  RussianStreet(city: 'Москва', street: 'Большая Бронная', lat: 55.7680, lng: 37.5910),
  RussianStreet(city: 'Москва', street: 'Малая Бронная', lat: 55.7670, lng: 37.5870),
  RussianStreet(city: 'Москва', street: 'Камергерский переулок', lat: 55.7650, lng: 37.5880),
  RussianStreet(city: 'Москва', street: 'Кузнецкий мост', lat: 55.7610, lng: 37.6240),
  RussianStreet(city: 'Москва', street: 'Петровка', lat: 55.7640, lng: 37.6180),
  RussianStreet(city: 'Москва', street: 'Столешников переулок', lat: 55.7630, lng: 37.6210),
  RussianStreet(city: 'Москва', street: 'Третьяковский проезд', lat: 55.7440, lng: 37.6250),
  RussianStreet(city: 'Москва', street: 'Кадашёвская набережная', lat: 55.7430, lng: 37.6280),
  RussianStreet(city: 'Москва', street: 'Большая Ордынка', lat: 55.7420, lng: 37.6270),
  RussianStreet(city: 'Москва', street: 'Малая Ордынка', lat: 55.7440, lng: 37.6250),
  RussianStreet(city: 'Москва', street: 'Пятницкая', lat: 55.7400, lng: 37.6270),
  RussianStreet(city: 'Москва', street: 'Большая Полянка', lat: 55.7360, lng: 37.6180),
  RussianStreet(city: 'Москва', street: 'Малая Полянка', lat: 55.7340, lng: 37.6150),
  RussianStreet(city: 'Москва', street: 'Шаболовка', lat: 55.7250, lng: 37.6080),
  RussianStreet(city: 'Москва', street: 'Люсиновская', lat: 55.7240, lng: 37.6130),
  RussianStreet(city: 'Москва', street: 'Дубининская', lat: 55.7220, lng: 37.6190),
  RussianStreet(city: 'Москва', street: 'Нагатинская', lat: 55.6820, lng: 37.6230),
  RussianStreet(city: 'Москва', street: 'Вавилова', lat: 55.7120, lng: 37.5730),
  RussianStreet(city: 'Москва', street: 'Ломоносовский проспект', lat: 55.6950, lng: 37.5350),
  RussianStreet(city: 'Москва', street: 'Михалковская', lat: 55.8180, lng: 37.5330),
  RussianStreet(city: 'Москва', street: 'Ленинградское шоссе', lat: 55.8500, lng: 37.5050),
  RussianStreet(city: 'Москва', street: 'Хорошёвское шоссе', lat: 55.7800, lng: 37.5210),
  RussianStreet(city: 'Москва', street: 'Курская', lat: 55.7570, lng: 37.6580),
  RussianStreet(city: 'Москва', street: 'Земляной вал', lat: 55.7420, lng: 37.6600),
  RussianStreet(city: 'Москва', street: 'Сретенский бульвар', lat: 55.7660, lng: 37.6370),
  RussianStreet(city: 'Москва', street: 'Таганская', lat: 55.7400, lng: 37.6530),
  RussianStreet(city: 'Москва', street: 'Большие Каменщики', lat: 55.7460, lng: 37.6400),
  RussianStreet(city: 'Москва', street: 'Малые Каменщики', lat: 55.7450, lng: 37.6380),
  RussianStreet(city: 'Москва', street: 'Новая площадь', lat: 55.7560, lng: 37.6180),
  RussianStreet(city: 'Москва', street: 'Чистые пруды', lat: 55.7640, lng: 37.6390),
  RussianStreet(city: 'Москва', street: 'Миусская', lat: 55.7590, lng: 37.6020),
  RussianStreet(city: 'Москва', street: 'Каретный ряд', lat: 55.7650, lng: 37.6070),
  RussianStreet(city: 'Москва', street: 'Рождественка', lat: 55.7640, lng: 37.6100),
  RussianStreet(city: 'Москва', street: 'Пушечная', lat: 55.7630, lng: 37.6140),
  RussianStreet(city: 'Москва', street: 'Романов переулок', lat: 55.7630, lng: 37.6060),
  RussianStreet(city: 'Москва', street: 'Васильковская', lat: 55.7150, lng: 37.5870),
  RussianStreet(city: 'Москва', street: 'Обручева', lat: 55.6890, lng: 37.5650),
  RussianStreet(city: 'Москва', street: 'Академика Бакулева', lat: 55.6950, lng: 37.5630),
  RussianStreet(city: 'Москва', street: 'Академика Боголюбова', lat: 55.6740, lng: 37.5710),
  RussianStreet(city: 'Москва', street: 'Академика Курчатова', lat: 55.6900, lng: 37.5750),
  RussianStreet(city: 'Москва', street: 'Академика Пилюгина', lat: 55.6800, lng: 37.5730),
  RussianStreet(city: 'Москва', street: 'Академика Анохина', lat: 55.6980, lng: 37.5590),
  RussianStreet(city: 'Москва', street: 'Академика Арцимовича', lat: 55.6870, lng: 37.5680),
  RussianStreet(city: 'Москва', street: 'Академика Волгина', lat: 55.6840, lng: 37.5710),
  RussianStreet(city: 'Москва', street: 'Академика Глушко', lat: 55.7150, lng: 37.5890),
  RussianStreet(city: 'Москва', street: 'Академика Келдыша', lat: 55.6860, lng: 37.5690),
  RussianStreet(city: 'Москва', street: 'Академика Комарова', lat: 55.6690, lng: 37.5480),
  RussianStreet(city: 'Москва', street: 'Академика Лукьянова', lat: 55.7000, lng: 37.5860),
  RussianStreet(city: 'Москва', street: 'Академика Опарина', lat: 55.6800, lng: 37.5740),
  RussianStreet(city: 'Москва', street: 'Академика Пиунова', lat: 55.7000, lng: 37.5800),
  RussianStreet(city: 'Москва', street: 'Академика Семёнова', lat: 55.6860, lng: 37.5650),
  RussianStreet(city: 'Москва', street: 'Академика Скрябина', lat: 55.6870, lng: 37.5630),
  RussianStreet(city: 'Москва', street: 'Академика Челомея', lat: 55.6950, lng: 37.5630),

  // ─── Видное ───
  RussianStreet(city: 'Видное', street: 'Зелёная', lat: 55.5510, lng: 37.7020),
  RussianStreet(city: 'Видное', street: 'Центральная', lat: 55.5530, lng: 37.6980),
  RussianStreet(city: 'Видное', street: 'Ленина', lat: 55.5540, lng: 37.7000),
  RussianStreet(city: 'Видное', street: 'Мира', lat: 55.5550, lng: 37.7010),
  RussianStreet(city: 'Видное', street: 'Советская', lat: 55.5520, lng: 37.6990),
  RussianStreet(city: 'Видное', street: 'Пушкина', lat: 55.5560, lng: 37.7030),
  RussianStreet(city: 'Видное', street: 'Гагарина', lat: 55.5570, lng: 37.7040),
  RussianStreet(city: 'Видное', street: 'Мичурина', lat: 55.5500, lng: 37.6970),
  RussianStreet(city: 'Видное', street: 'Садовая', lat: 55.5545, lng: 37.7015),
  RussianStreet(city: 'Видное', street: 'Полевая', lat: 55.5535, lng: 37.6995),
  RussianStreet(city: 'Видное', street: 'Лесная', lat: 55.5555, lng: 37.7025),
  RussianStreet(city: 'Видное', street: 'Речная', lat: 55.5515, lng: 37.6985),
  RussianStreet(city: 'Видное', street: 'Полынковская', lat: 55.5525, lng: 37.6975),
  RussianStreet(city: 'Видное', street: 'Дачная', lat: 55.5565, lng: 37.7035),
  RussianStreet(city: 'Видное', street: 'Кооперативная', lat: 55.5540, lng: 37.7005),

  // ─── Санкт-Петербург ───
  RussianStreet(city: 'Санкт-Петербург', street: 'Невский проспект', lat: 59.9350, lng: 30.3270),
  RussianStreet(city: 'Санкт-Петербург', street: 'Большая Морская', lat: 59.9350, lng: 30.3170),
  RussianStreet(city: 'Санкт-Петербург', street: 'Литейный проспект', lat: 59.9430, lng: 30.3260),
  RussianStreet(city: 'Санкт-Петербург', street: 'Московский проспект', lat: 59.9200, lng: 30.3150),
  RussianStreet(city: 'Санкт-Петербург', street: 'Вознесенский проспект', lat: 59.9290, lng: 30.3190),
  RussianStreet(city: 'Санкт-Петербург', street: 'Казачья', lat: 59.9280, lng: 30.3220),
  RussianStreet(city: 'Санкт-Петербург', street: 'Конная', lat: 59.9280, lng: 30.3130),
  RussianStreet(city: 'Санкт-Петербург', street: 'Садовая', lat: 59.9270, lng: 30.3250),
  RussianStreet(city: 'Санкт-Петербург', street: 'Большая Конюшенная', lat: 59.9350, lng: 30.3210),
  RussianStreet(city: 'Санкт-Петербург', street: 'Малая Конюшенная', lat: 59.9360, lng: 30.3220),
  RussianStreet(city: 'Санкт-Петербург', street: 'Рубинштейна', lat: 59.9290, lng: 30.3340),
  RussianStreet(city: 'Санкт-Петербург', street: 'Лиговский проспект', lat: 59.9240, lng: 30.3450),
  RussianStreet(city: 'Санкт-Петербург', street: 'Загородный проспект', lat: 59.9250, lng: 30.3300),
  RussianStreet(city: 'Санкт-Петербург', street: 'Владимирский проспект', lat: 59.9260, lng: 30.3350),
  RussianStreet(city: 'Санкт-Петербург', street: 'Кирочная', lat: 59.9410, lng: 30.3450),
  RussianStreet(city: 'Санкт-Петербург', street: 'Маяковского', lat: 59.9340, lng: 30.3320),
  RussianStreet(city: 'Санкт-Петербург', street: 'Басков переулок', lat: 59.9330, lng: 30.3310),
  RussianStreet(city: 'Санкт-Петербург', street: 'Итальянская', lat: 59.9330, lng: 30.3290),
  RussianStreet(city: 'Санкт-Петербург', street: 'Брюсов переулок', lat: 59.9340, lng: 30.3280),
  RussianStreet(city: 'Санкт-Петербург', street: 'Достоевского', lat: 59.9300, lng: 30.3400),
  RussianStreet(city: 'Санкт-Петербург', street: 'Воскресенская набережная', lat: 59.9300, lng: 30.3210),
  RussianStreet(city: 'Санкт-Петербург', street: 'Адмиралтейская набережная', lat: 59.9320, lng: 30.3100),
  RussianStreet(city: 'Санкт-Петербург', street: 'Университетская набережная', lat: 59.9410, lng: 30.2990),
  RussianStreet(city: 'Санкт-Петербург', street: 'Дворцовая набережная', lat: 59.9430, lng: 30.3050),
  RussianStreet(city: 'Санкт-Петербург', street: 'Каменноостровский проспект', lat: 59.9500, lng: 30.3250),
  RussianStreet(city: 'Санкт-Петербург', street: 'Кронверкский проспект', lat: 59.9520, lng: 30.3160),
  RussianStreet(city: 'Санкт-Петербург', street: 'Чкаловская', lat: 59.9550, lng: 30.3180),

  // ─── Видное / МО дополнительные ───
  RussianStreet(city: 'Видное', street: 'Ленина', lat: 55.5541, lng: 37.7006),
  RussianStreet(city: 'Видное', street: 'Мира', lat: 55.5541, lng: 37.7010),
  RussianStreet(city: 'Видное', street: 'Гагарина', lat: 55.5541, lng: 37.7015),
  RussianStreet(city: 'Видное', street: 'Пушкина', lat: 55.5541, lng: 37.7020),
  RussianStreet(city: 'Видное', street: 'Советская', lat: 55.5541, lng: 37.7025),

  // ─── Балашиха ───
  RussianStreet(city: 'Балашиха', street: 'Ленина', lat: 55.7420, lng: 37.9455),
  RussianStreet(city: 'Балашиха', street: 'Мира', lat: 55.7430, lng: 37.9460),
  RussianStreet(city: 'Балашиха', street: 'Советская', lat: 55.7410, lng: 37.9450),
  RussianStreet(city: 'Балашиха', street: 'Гагарина', lat: 55.7440, lng: 37.9470),
  RussianStreet(city: 'Балашиха', street: 'Пушкина', lat: 55.7425, lng: 37.9465),

  // ─── Химки ───
  RussianStreet(city: 'Химки', street: 'Ленина', lat: 55.8947, lng: 37.4350),
  RussianStreet(city: 'Химки', street: 'Мира', lat: 55.8957, lng: 37.4360),
  RussianStreet(city: 'Химки', street: 'Советская', lat: 55.8937, lng: 37.4340),
  RussianStreet(city: 'Химки', street: 'Гагарина', lat: 55.8967, lng: 37.4370),

  // ─── Мытищи ───
  RussianStreet(city: 'Мытищи', street: 'Ленина', lat: 55.9156, lng: 37.7304),
  RussianStreet(city: 'Мытищи', street: 'Олимпийский проспект', lat: 55.9166, lng: 37.7314),
  RussianStreet(city: 'Мытищи', street: 'Транзитная', lat: 55.9146, lng: 37.7294),

  // ─── Подольск ───
  RussianStreet(city: 'Подольск', street: 'Ленина', lat: 55.4304, lng: 37.5538),
  RussianStreet(city: 'Подольск', street: 'Кирова', lat: 55.4314, lng: 37.5548),
  RussianStreet(city: 'Подольск', street: 'Генерала Варенникова', lat: 55.4294, lng: 37.5528),

  // ─── Одинцово ───
  RussianStreet(city: 'Одинцово', street: 'Можайское шоссе', lat: 55.6783, lng: 37.2742),
  RussianStreet(city: 'Одинцово', street: 'Ленина', lat: 55.6793, lng: 37.2752),

  // ─── Люберцы ───
  RussianStreet(city: 'Люберцы', street: 'Ленина', lat: 55.6761, lng: 37.8947),
  RussianStreet(city: 'Люберцы', street: 'Кирова', lat: 55.6771, lng: 37.8957),

  // ─── Королёв ───
  RussianStreet(city: 'Королёв', street: 'Космонавтов', lat: 55.9167, lng: 37.8550),
  RussianStreet(city: 'Королёв', street: 'Советская', lat: 55.9177, lng: 37.8560),

  // ─── Красногорск ───
  RussianStreet(city: 'Красногорск', street: 'Ленина', lat: 55.8206, lng: 37.3314),
  RussianStreet(city: 'Красногорск', street: 'Красногорская', lat: 55.8216, lng: 37.3324),

  // ─── Домодедово ───
  RussianStreet(city: 'Домодедово', street: 'Ленина', lat: 55.4372, lng: 37.7586),
  RussianStreet(city: 'Домодедово', street: 'Можайская', lat: 55.4382, lng: 37.7596),

  // ─── Серпухов ───
  RussianStreet(city: 'Серпухов', street: 'Ленина', lat: 54.9142, lng: 37.4114),
  RussianStreet(city: 'Серпухов', street: 'Октябрьская', lat: 54.9152, lng: 37.4124),

  // ─── Коломна ───
  RussianStreet(city: 'Коломна', street: 'Ленина', lat: 55.0794, lng: 38.7783),
  RussianStreet(city: 'Коломна', street: 'Заборьевская', lat: 55.0804, lng: 38.7793),

  // ─── Екатеринбург ───
  RussianStreet(city: 'Екатеринбург', street: 'Малышева', lat: 56.8357, lng: 60.5957),
  RussianStreet(city: 'Екатеринбург', street: 'Ленина', lat: 56.8389, lng: 60.6057),
  RussianStreet(city: 'Екатеринбург', street: 'Космонавтов', lat: 56.8400, lng: 60.6067),
  RussianStreet(city: 'Екатеринбург', street: 'Белинского', lat: 56.8370, lng: 60.6030),
  RussianStreet(city: 'Екатеринбург', street: 'Мира', lat: 56.8395, lng: 60.6060),
  RussianStreet(city: 'Екатеринбург', street: '8 Марта', lat: 56.8340, lng: 60.5940),
  RussianStreet(city: 'Екатеринбург', street: 'Куйбышева', lat: 56.8360, lng: 60.6010),
  RussianStreet(city: 'Екатеринбург', street: 'Радищева', lat: 56.8375, lng: 60.6045),
  RussianStreet(city: 'Екатеринбург', street: 'Шверника', lat: 56.8350, lng: 60.5990),
  RussianStreet(city: 'Екатеринбург', street: 'Советская', lat: 56.8382, lng: 60.6050),

  // ─── Челябинск ───
  RussianStreet(city: 'Челябинск', street: 'Кирова', lat: 55.1644, lng: 61.4368),
  RussianStreet(city: 'Челябинск', street: 'Ленина', lat: 55.1654, lng: 61.4378),
  RussianStreet(city: 'Челябинск', street: 'Мира', lat: 55.1634, lng: 61.4358),
  RussianStreet(city: 'Челябинск', street: 'Советская', lat: 55.1664, lng: 61.4388),
  RussianStreet(city: 'Челябинск', street: 'Труда', lat: 55.1624, lng: 61.4348),
  RussianStreet(city: 'Челябинск', street: 'Гагарина', lat: 55.1674, lng: 61.4398),

  // ─── Казань ───
  RussianStreet(city: 'Казань', street: 'Баумана', lat: 55.7887, lng: 49.1221),
  RussianStreet(city: 'Казань', street: 'Кремлёвская', lat: 55.7970, lng: 49.1120),
  RussianStreet(city: 'Казань', street: 'Университетская', lat: 55.7900, lng: 49.1190),
  RussianStreet(city: 'Казань', street: 'Пушкина', lat: 55.7877, lng: 49.1211),
  RussianStreet(city: 'Казань', street: 'Советская', lat: 55.7867, lng: 49.1231),
  RussianStreet(city: 'Казань', street: 'Чернышевского', lat: 55.7857, lng: 49.1241),
  RussianStreet(city: 'Казань', street: 'Фатыха Амирхана', lat: 55.7847, lng: 49.1251),
  RussianStreet(city: 'Казань', street: 'Островского', lat: 55.7837, lng: 49.1261),

  // ─── Нижний Новгород ───
  RussianStreet(city: 'Нижний Новгород', street: 'Большая Покровская', lat: 56.2965, lng: 43.9361),
  RussianStreet(city: 'Нижний Новгород', street: 'Большая Дмитриевская', lat: 56.2975, lng: 43.9371),
  RussianStreet(city: 'Нижний Новгород', street: 'Рождественская', lat: 56.2955, lng: 43.9351),
  RussianStreet(city: 'Нижний Новгород', street: 'Советская', lat: 56.2945, lng: 43.9341),
  RussianStreet(city: 'Нижний Новгород', street: 'Ленина', lat: 56.2985, lng: 43.9381),
  RussianStreet(city: 'Нижний Новгород', street: 'Мира', lat: 56.2995, lng: 43.9391),

  // ─── Самара ───
  RussianStreet(city: 'Самара', street: 'Ленина', lat: 53.1959, lng: 50.1002),
  RussianStreet(city: 'Самара', street: 'Московская', lat: 53.1969, lng: 50.1012),
  RussianStreet(city: 'Самара', street: 'Чапаевская', lat: 53.1949, lng: 50.0992),
  RussianStreet(city: 'Самара', street: 'Красноармейская', lat: 53.1979, lng: 50.1022),
  RussianStreet(city: 'Самара', street: 'Галактионовская', lat: 53.1939, lng: 50.0982),

  // ─── Воронеж ───
  RussianStreet(city: 'Воронеж', street: 'Кольцовская', lat: 51.6720, lng: 39.1843),
  RussianStreet(city: 'Воронеж', street: 'Плехановская', lat: 51.6730, lng: 39.1853),
  RussianStreet(city: 'Воронеж', street: 'Ворошилова', lat: 51.6710, lng: 39.1833),
  RussianStreet(city: 'Воронеж', street: '9 Января', lat: 51.6740, lng: 39.1863),
  RussianStreet(city: 'Воронеж', street: 'Фридриха Энгельса', lat: 51.6700, lng: 39.1823),

  // ─── Краснодар ───
  RussianStreet(city: 'Краснодар', street: 'Красная', lat: 45.0355, lng: 38.9753),
  RussianStreet(city: 'Краснодар', street: 'Длинная', lat: 45.0365, lng: 38.9763),
  RussianStreet(city: 'Краснодар', street: 'Северная', lat: 45.0345, lng: 38.9743),
  RussianStreet(city: 'Краснодар', street: 'Западная', lat: 45.0375, lng: 38.9773),
  RussianStreet(city: 'Краснодар', street: 'Мира', lat: 45.0335, lng: 38.9733),

  // ─── Ростов-на-Дону ───
  RussianStreet(city: 'Ростов-на-Дону', street: 'Большая Садовая', lat: 47.2357, lng: 39.7015),
  RussianStreet(city: 'Ростов-на-Дону', street: 'Пушкинская', lat: 47.2367, lng: 39.7025),
  RussianStreet(city: 'Ростов-на-Дону', street: 'Советская', lat: 47.2347, lng: 39.7005),
  RussianStreet(city: 'Ростов-на-Дону', street: 'Ленина', lat: 47.2377, lng: 39.7035),
  RussianStreet(city: 'Ростов-на-Дону', street: 'Станкевича', lat: 47.2337, lng: 39.6995),

  // ─── Новосибирск ───
  RussianStreet(city: 'Новосибирск', street: 'Красный проспект', lat: 55.0084, lng: 82.9357),
  RussianStreet(city: 'Новосибирск', street: 'Ленина', lat: 55.0094, lng: 82.9367),
  RussianStreet(city: 'Новосибирск', street: 'Дуси Ковальчук', lat: 55.0074, lng: 82.9347),
  RussianStreet(city: 'Новосибирск', street: 'Гоголя', lat: 55.0104, lng: 82.9377),
  RussianStreet(city: 'Новосибирск', street: 'Ватутина', lat: 55.0064, lng: 82.9337),

  // ─── Красноярск ───
  RussianStreet(city: 'Красноярск', street: 'Ленина', lat: 56.0153, lng: 92.8932),
  RussianStreet(city: 'Красноярск', street: 'Мира', lat: 56.0163, lng: 92.8942),
  RussianStreet(city: 'Красноярск', street: 'Красноярская', lat: 56.0143, lng: 92.8922),
  RussianStreet(city: 'Красноярск', street: 'Свердлова', lat: 56.0173, lng: 92.8952),
  RussianStreet(city: 'Красноярск', street: 'Урицкого', lat: 56.0133, lng: 92.8912),

  // ─── Уфа ───
  RussianStreet(city: 'Уфа', street: 'Ленина', lat: 54.7431, lng: 55.9721),
  RussianStreet(city: 'Уфа', street: 'Советская', lat: 54.7441, lng: 55.9731),
  RussianStreet(city: 'Уфа', street: 'Мира', lat: 54.7421, lng: 55.9711),
  RussianStreet(city: 'Уфа', street: 'Красная', lat: 54.7451, lng: 55.9741),
  RussianStreet(city: 'Уфа', street: 'Гоголя', lat: 54.7411, lng: 55.9701),

  // ─── Волгоград ───
  RussianStreet(city: 'Волгоград', street: 'Мира', lat: 48.7080, lng: 44.5133),
  RussianStreet(city: 'Волгоград', street: 'Ленина', lat: 48.7090, lng: 44.5143),
  RussianStreet(city: 'Волгоград', street: 'Советская', lat: 48.7070, lng: 44.5123),

  // ─── Тольятти ───
  RussianStreet(city: 'Тольятти', street: 'Ленина', lat: 53.5078, lng: 49.4204),
  RussianStreet(city: 'Тольятти', street: 'Мира', lat: 53.5088, lng: 49.4214),
  RussianStreet(city: 'Тольятти', street: 'Автозаводская', lat: 53.5068, lng: 49.4194),

  // ─── Саратов ───
  RussianStreet(city: 'Саратов', street: 'Московская', lat: 51.5336, lng: 46.0342),
  RussianStreet(city: 'Саратов', street: 'Ленина', lat: 51.5346, lng: 46.0352),
  RussianStreet(city: 'Саратов', street: 'Чернышевского', lat: 51.5326, lng: 46.0332),

  // ─── Кемерово ───
  RussianStreet(city: 'Кемерово', street: 'Ленина', lat: 55.3333, lng: 86.0833),
  RussianStreet(city: 'Кемерово', street: 'Красная', lat: 55.3343, lng: 86.0843),
  RussianStreet(city: 'Кемерово', street: 'Советская', lat: 55.3323, lng: 86.0823),

  // ─── Иркутск ───
  RussianStreet(city: 'Иркутск', street: 'Ленина', lat: 52.2978, lng: 104.2964),
  RussianStreet(city: 'Иркутск', street: 'Советская', lat: 52.2988, lng: 104.2974),
  RussianStreet(city: 'Иркутск', street: 'Карла Маркса', lat: 52.2968, lng: 104.2954),

  // ─── Тула ───
  RussianStreet(city: 'Тула', street: 'Кутузова', lat: 54.1939, lng: 37.6178),
  RussianStreet(city: 'Тула', street: 'Ленина', lat: 54.1949, lng: 37.6188),
  RussianStreet(city: 'Тула', street: 'Мира', lat: 54.1929, lng: 37.6168),

  // ─── Ярославль ───
  RussianStreet(city: 'Ярославль', street: 'Советская', lat: 57.6261, lng: 39.8736),
  RussianStreet(city: 'Ярославль', street: 'Волгоградская', lat: 57.6271, lng: 39.8746),
  RussianStreet(city: 'Ярославль', street: 'Свободы', lat: 57.6251, lng: 39.8726),

  // ─── Омск ───
  RussianStreet(city: 'Омск', street: 'Ленина', lat: 54.9885, lng: 73.3242),
  RussianStreet(city: 'Омск', street: 'Мира', lat: 54.9895, lng: 73.3252),
  RussianStreet(city: 'Омск', street: 'Красный путь', lat: 54.9875, lng: 73.3232),

  // ─── Барнаул ───
  RussianStreet(city: 'Барнаул', street: 'Ленина', lat: 53.3468, lng: 83.7769),
  RussianStreet(city: 'Барнаул', street: 'Мира', lat: 53.3478, lng: 83.7779),
  RussianStreet(city: 'Барнаул', street: 'Советская', lat: 53.3458, lng: 83.7759),

  // ─── Ижевск ───
  RussianStreet(city: 'Ижевск', street: 'Ленина', lat: 56.8525, lng: 53.2338),
  RussianStreet(city: 'Ижевск', street: 'Мира', lat: 56.8535, lng: 53.2348),
  RussianStreet(city: 'Ижевск', street: 'Советская', lat: 56.8515, lng: 53.2328),

  // ─── Тверь ───
  RussianStreet(city: 'Тверь', street: 'Ленина', lat: 56.8587, lng: 35.9176),
  RussianStreet(city: 'Тверь', street: 'Советская', lat: 56.8597, lng: 35.9186),
  RussianStreet(city: 'Тверь', street: 'Пушкинская', lat: 56.8577, lng: 35.9166),

  // ─── Волгоград (extra) ───
  RussianStreet(city: 'Волгоград', street: 'Центральная', lat: 48.7100, lng: 44.5153),
  RussianStreet(city: 'Волгоград', street: 'Гвардейская', lat: 48.7060, lng: 44.5113),

  // ─── Белгород ───
  RussianStreet(city: 'Белгород', street: 'Ленина', lat: 50.6035, lng: 36.5836),
  RussianStreet(city: 'Белгород', street: 'Мира', lat: 50.6045, lng: 36.5846),
  RussianStreet(city: 'Белгород', street: 'Достоевского', lat: 50.6025, lng: 36.5826),

  // ─── Курск ───
  RussianStreet(city: 'Курск', street: 'Ленина', lat: 51.7372, lng: 36.1872),
  RussianStreet(city: 'Курск', street: 'Красная', lat: 51.7382, lng: 36.1882),
  RussianStreet(city: 'Курск', street: 'Советская', lat: 51.7362, lng: 36.1862),

  // ─── Липецк ───
  RussianStreet(city: 'Липецк', street: 'Ленина', lat: 52.6052, lng: 39.5727),
  RussianStreet(city: 'Липецк', street: 'Мира', lat: 52.6062, lng: 39.5737),
  RussianStreet(city: 'Липецк', street: 'Советская', lat: 52.6042, lng: 39.5717),

  // ─── Тамбов ───
  RussianStreet(city: 'Тамбов', street: 'Советская', lat: 52.7214, lng: 41.4174),
  RussianStreet(city: 'Тамбов', street: 'Ленина', lat: 52.7224, lng: 41.4184),
  RussianStreet(city: 'Тамбов', street: 'Мичурина', lat: 52.7204, lng: 41.4164),

  // ─── Оренбург ───
  RussianStreet(city: 'Оренбург', street: 'Ленина', lat: 51.7681, lng: 55.0968),
  RussianStreet(city: 'Оренбург', street: 'Мира', lat: 51.7691, lng: 55.0978),
  RussianStreet(city: 'Оренбург', street: 'Советская', lat: 51.7671, lng: 55.0958),

  // ─── Пермь ───
  RussianStreet(city: 'Пермь', street: 'Ленина', lat: 58.0105, lng: 56.2502),
  RussianStreet(city: 'Пермь', street: 'Сибирская', lat: 58.0115, lng: 56.2512),
  RussianStreet(city: 'Пермь', street: 'Мира', lat: 58.0095, lng: 56.2492),

  // ─── Пенза ───
  RussianStreet(city: 'Пенза', street: 'Ленина', lat: 53.1959, lng: 45.0178),
  RussianStreet(city: 'Пенза', street: 'Мира', lat: 53.1969, lng: 45.0188),
  RussianStreet(city: 'Пенза', street: 'Советская', lat: 53.1949, lng: 45.0168),

  // ─── Ульяновск ───
  RussianStreet(city: 'Ульяновск', street: 'Ленина', lat: 54.3000, lng: 48.3500),
  RussianStreet(city: 'Ульяновск', street: 'Гончарова', lat: 54.3010, lng: 48.3510),
  RussianStreet(city: 'Ульяновск', street: 'Мира', lat: 54.2990, lng: 48.3490),

  // ─── Чебоксары ───
  RussianStreet(city: 'Чебоксары', street: 'Ленина', lat: 56.1322, lng: 47.2519),
  RussianStreet(city: 'Чебоксары', street: 'Мира', lat: 56.1332, lng: 47.2529),
  RussianStreet(city: 'Чебоксары', street: 'Советская', lat: 56.1312, lng: 47.2509),

  // ─── Калининград ───
  RussianStreet(city: 'Калининград', street: 'Ленина', lat: 54.7104, lng: 20.4522),
  RussianStreet(city: 'Калининград', street: 'Театральная', lat: 54.7114, lng: 20.4532),
  RussianStreet(city: 'Калининград', street: 'Багратиона', lat: 54.7094, lng: 20.4512),

  // ─── Махачкала ───
  RussianStreet(city: 'Махачкала', street: 'Ленина', lat: 42.9849, lng: 47.5047),
  RussianStreet(city: 'Махачкала', street: 'Даниялова', lat: 42.9859, lng: 47.5057),
  RussianStreet(city: 'Махачкала', street: 'Ирчи Казака', lat: 42.9839, lng: 47.5037),

  // ─── Грозный ───
  RussianStreet(city: 'Грозный', street: 'Ленина', lat: 43.3125, lng: 45.6989),
  RussianStreet(city: 'Грозный', street: 'Мира', lat: 43.3135, lng: 45.6999),
  RussianStreet(city: 'Грозный', street: 'Советская', lat: 43.3115, lng: 45.6979),

  // ─── Набережные Челны ───
  RussianStreet(city: 'Набережные Челны', street: 'Ленина', lat: 55.7250, lng: 51.8333),
  RussianStreet(city: 'Набережные Челны', street: 'Камская', lat: 55.7260, lng: 51.8343),
  RussianStreet(city: 'Набережные Челны', street: 'Мира', lat: 55.7240, lng: 51.8323),

  // ─── Стерлитамак ───
  RussianStreet(city: 'Стерлитамак', street: 'Ленина', lat: 53.6667, lng: 55.9667),
  RussianStreet(city: 'Стерлитамак', street: 'Мира', lat: 53.6677, lng: 55.9677),
  RussianStreet(city: 'Стерлитамак', street: 'Советская', lat: 53.6657, lng: 55.9657),

  // ─── Мурманск ───
  RussianStreet(city: 'Мурманск', street: 'Ленина', lat: 68.9585, lng: 33.0827),
  RussianStreet(city: 'Мурманск', street: 'Полярная', lat: 68.9595, lng: 33.0837),
  RussianStreet(city: 'Мурманск', street: 'Шмидта', lat: 68.9575, lng: 33.0817),

  // ─── Архангельск ───
  RussianStreet(city: 'Архангельск', street: 'Ленина', lat: 64.5399, lng: 40.5152),
  RussianStreet(city: 'Архангельск', street: 'Владимирская', lat: 64.5409, lng: 40.5162),
  RussianStreet(city: 'Архангельск', street: 'Троицкий проспект', lat: 64.5389, lng: 40.5142),

  // ─── Сыктывкар ───
  RussianStreet(city: 'Сыктывкар', street: 'Ленина', lat: 61.6688, lng: 50.8364),
  RussianStreet(city: 'Сыктывкар', street: 'Октябрьская', lat: 61.6698, lng: 50.8374),
  RussianStreet(city: 'Сыктывкар', street: 'Советская', lat: 61.6678, lng: 50.8354),

  // ─── Вологда ───
  RussianStreet(city: 'Вологда', street: 'Мира', lat: 59.2205, lng: 39.8915),
  RussianStreet(city: 'Вологда', street: 'Ленина', lat: 59.2215, lng: 39.8925),
  RussianStreet(city: 'Вологда', street: 'Советская', lat: 59.2195, lng: 39.8905),

  // ─── Великий Новгород ───
  RussianStreet(city: 'Великий Новгород', street: 'Советская', lat: 58.5217, lng: 31.2756),
  RussianStreet(city: 'Великий Новгород', street: 'Большая Московская', lat: 58.5227, lng: 31.2766),
  RussianStreet(city: 'Великий Новгород', street: 'Лукьянова', lat: 58.5207, lng: 31.2746),

  // ─── Псков ───
  RussianStreet(city: 'Псков', street: 'Ленина', lat: 57.8136, lng: 28.3496),
  RussianStreet(city: 'Псков', street: 'Советская', lat: 57.8146, lng: 28.3506),
  RussianStreet(city: 'Псков', street: 'Некрасова', lat: 57.8126, lng: 28.3486),

  // ─── Смоленск ───
  RussianStreet(city: 'Смоленск', street: 'Дзержинского', lat: 54.7826, lng: 32.0453),
  RussianStreet(city: 'Смоленск', street: 'Ленина', lat: 54.7836, lng: 32.0463),
  RussianStreet(city: 'Смоленск', street: 'Советская', lat: 54.7816, lng: 32.0443),

  // ─── Калуга ───
  RussianStreet(city: 'Калуга', street: 'Ленина', lat: 54.5147, lng: 36.2708),
  RussianStreet(city: 'Калуга', street: 'Кирова', lat: 54.5157, lng: 36.2718),
  RussianStreet(city: 'Калуга', street: 'Мира', lat: 54.5137, lng: 36.2698),

  // ─── Рязань ───
  RussianStreet(city: 'Рязань', street: 'Пушкинская', lat: 54.6296, lng: 39.6911),
  RussianStreet(city: 'Рязань', street: 'Ленина', lat: 54.6306, lng: 39.6921),
  RussianStreet(city: 'Рязань', street: 'Советская', lat: 54.6286, lng: 39.6901),

  // ─── Брянск ───
  RussianStreet(city: 'Брянск', street: 'Фокина', lat: 53.2521, lng: 34.3717),
  RussianStreet(city: 'Брянск', street: 'Ленина', lat: 53.2531, lng: 34.3727),
  RussianStreet(city: 'Брянск', street: 'Домостроительная', lat: 53.2511, lng: 34.3707),

  // ─── Орёл ───
  RussianStreet(city: 'Орёл', street: 'Любимовского', lat: 52.9672, lng: 36.0694),
  RussianStreet(city: 'Орёл', street: 'Советская', lat: 52.9682, lng: 36.0704),
  RussianStreet(city: 'Орёл', street: 'Московская', lat: 52.9662, lng: 36.0684),

  // ─── Кострома ───
  RussianStreet(city: 'Кострома', street: 'Советская', lat: 57.7667, lng: 40.9333),
  RussianStreet(city: 'Кострома', street: 'Мира', lat: 57.7677, lng: 40.9343),
  RussianStreet(city: 'Кострома', street: 'Урицкого', lat: 57.7657, lng: 40.9323),

  // ─── Иваново ───
  RussianStreet(city: 'Иваново', street: 'Шチпичёва', lat: 57.0040, lng: 40.9842),
  RussianStreet(city: 'Иваново', street: 'Советская', lat: 57.0050, lng: 40.9852),
  RussianStreet(city: 'Иваново', street: 'Ленина', lat: 57.0030, lng: 40.9832),

  // ─── Владимир ───
  RussianStreet(city: 'Владимир', street: 'Великая', lat: 56.1290, lng: 40.4068),
  RussianStreet(city: 'Владимир', street: 'Горького', lat: 56.1300, lng: 40.4078),
  RussianStreet(city: 'Владимир', street: 'Советская', lat: 56.1280, lng: 40.4058),

  // ─── Киров ───
  RussianStreet(city: 'Киров', street: 'Советская', lat: 58.6035, lng: 49.6680),
  RussianStreet(city: 'Киров', street: 'Кирова', lat: 58.6045, lng: 49.6690),
  RussianStreet(city: 'Киров', street: 'Денисова', lat: 58.6025, lng: 49.6670),

  // ─── Омск (extra) ───
  RussianStreet(city: 'Омск', street: 'Карла Маркса', lat: 54.9895, lng: 73.3252),
  RussianStreet(city: 'Омск', street: 'Советская', lat: 54.9875, lng: 73.3232),

  // ─── Тюмень ───
  RussianStreet(city: 'Тюмень', street: 'Ленина', lat: 57.1522, lng: 65.5550),
  RussianStreet(city: 'Тюмень', street: 'Мира', lat: 57.1532, lng: 65.5560),
  RussianStreet(city: 'Тюмень', street: 'Советская', lat: 57.1512, lng: 65.5540),

  // ─── Сургут ───
  RussianStreet(city: 'Сургут', street: 'Ленина', lat: 61.2500, lng: 73.4000),
  RussianStreet(city: 'Сургут', street: 'Мира', lat: 61.2510, lng: 73.4010),
  RussianStreet(city: 'Сургут', street: 'Генерала Иванова', lat: 61.2490, lng: 73.3990),

  // ─── Хабаровск ───
  RussianStreet(city: 'Хабаровск', street: 'Серышева', lat: 48.4827, lng: 135.0837),
  RussianStreet(city: 'Хабаровск', street: 'Ленина', lat: 48.4837, lng: 135.0847),
  RussianStreet(city: 'Хабаровск', street: 'Карла Маркса', lat: 48.4817, lng: 135.0827),

  // ─── Владивосток ───
  RussianStreet(city: 'Владивосток', street: 'Светланская', lat: 43.1155, lng: 131.8855),
  RussianStreet(city: 'Владивосток', street: 'Океанский проспект', lat: 43.1165, lng: 131.8865),
  RussianStreet(city: 'Владивосток', street: 'Ленина', lat: 43.1145, lng: 131.8845),

  // ─── Южно-Сахалинск ───
  RussianStreet(city: 'Южно-Сахалинск', street: 'Ленина', lat: 46.9589, lng: 142.7386),
  RussianStreet(city: 'Южно-Сахалинск', street: 'Коммунистическая', lat: 46.9599, lng: 142.7396),
  RussianStreet(city: 'Южно-Сахалинск', street: 'Чехова', lat: 46.9579, lng: 142.7376),

  // ─── Петропавловск-Камчатский ───
  RussianStreet(city: 'Петропавловск-Камчатский', street: 'Ленина', lat: 53.0131, lng: 158.6483),
  RussianStreet(city: 'Петропавловск-Камчатский', street: 'Кутузова', lat: 53.0141, lng: 158.6493),
  RussianStreet(city: 'Петропавловск-Камчатский', street: 'Мира', lat: 53.0121, lng: 158.6473),

  // ─── Магадан ───
  RussianStreet(city: 'Магадан', street: 'Ленина', lat: 59.5683, lng: 150.8000),
  RussianStreet(city: 'Магадан', street: 'Орловского', lat: 59.5693, lng: 150.8010),
  RussianStreet(city: 'Магадан', street: 'Портовая', lat: 59.5673, lng: 150.7990),

  // ─── Благовещенск ───
  RussianStreet(city: 'Благовещенск', street: 'Ленина', lat: 50.2722, lng: 127.5406),
  RussianStreet(city: 'Благовещенск', street: 'Конфедератов', lat: 50.2732, lng: 127.5416),
  RussianStreet(city: 'Благовещенск', street: 'Игнатьевская', lat: 50.2712, lng: 127.5396),

  // ─── Чита ───
  RussianStreet(city: 'Чита', street: 'Ленина', lat: 52.0333, lng: 113.5000),
  RussianStreet(city: 'Чита', street: 'Амурская', lat: 52.0343, lng: 113.5010),
  RussianStreet(city: 'Чита', street: 'Бабушкина', lat: 52.0323, lng: 113.4990),

  // ─── Горно-Алтайск ───
  RussianStreet(city: 'Горно-Алтайск', street: 'Ленина', lat: 51.9583, lng: 85.9558),
  RussianStreet(city: 'Горно-Алтайск', street: 'Коммунистическая', lat: 51.9593, lng: 85.9568),
  RussianStreet(city: 'Горно-Алтайск', street: 'Советская', lat: 51.9573, lng: 85.9548),

  // ─── Кызыл ───
  RussianStreet(city: 'Кызыл', street: 'Ленина', lat: 51.7167, lng: 94.4500),
  RussianStreet(city: 'Кызыл', street: 'Мира', lat: 51.7177, lng: 94.4510),
  RussianStreet(city: 'Кызыл', street: 'Советская', lat: 51.7157, lng: 94.4490),

  // ─── Абакан ───
  RussianStreet(city: 'Абакан', street: 'Ленина', lat: 53.7208, lng: 91.4414),
  RussianStreet(city: 'Абакан', street: 'Советская', lat: 53.7218, lng: 91.4424),
  RussianStreet(city: 'Абакан', street: 'Коммунистическая', lat: 53.7198, lng: 91.4404),

  // ─── Элиста ───
  RussianStreet(city: 'Элиста', street: 'Ленина', lat: 46.3083, lng: 44.2558),
  RussianStreet(city: 'Элиста', street: 'Мира', lat: 46.3093, lng: 44.2568),
  RussianStreet(city: 'Элиста', street: 'Советская', lat: 46.3073, lng: 44.2548),

  // ─── Нальчик ───
  RussianStreet(city: 'Нальчик', street: 'Ленина', lat: 43.4846, lng: 43.6072),
  RussianStreet(city: 'Нальчик', street: 'Мира', lat: 43.4856, lng: 43.6082),
  RussianStreet(city: 'Нальчик', street: 'Кабардинская', lat: 43.4836, lng: 43.6062),

  // ─── Владикавказ ───
  RussianStreet(city: 'Владикавказ', street: 'Ленина', lat: 43.0205, lng: 44.6820),
  RussianStreet(city: 'Владикавказ', street: 'Мира', lat: 43.0215, lng: 44.6830),
  RussianStreet(city: 'Владикавказ', street: 'Советская', lat: 43.0195, lng: 44.6810),

  // ─── Улан-Удэ ───
  RussianStreet(city: 'Улан-Удэ', street: 'Ленина', lat: 51.8333, lng: 107.5833),
  RussianStreet(city: 'Улан-Удэ', street: 'Коммунистическая', lat: 51.8343, lng: 107.5843),
  RussianStreet(city: 'Улан-Удэ', street: 'Советская', lat: 51.8323, lng: 107.5823),

  // ─── Петрозаводск ───
  RussianStreet(city: 'Петрозаводск', street: 'Ленина', lat: 61.7969, lng: 34.3589),
  RussianStreet(city: 'Петрозаводск', street: 'Кирова', lat: 61.7979, lng: 34.3599),
  RussianStreet(city: 'Петрозаводск', street: 'Советская', lat: 61.7959, lng: 34.3579),

  // ─── Салехард ───
  RussianStreet(city: 'Салехард', street: 'Ленина', lat: 66.5298, lng: 66.6036),
  RussianStreet(city: 'Салехард', street: 'Урицкого', lat: 66.5308, lng: 66.6046),
  RussianStreet(city: 'Салехард', street: 'Мира', lat: 66.5288, lng: 66.6026),

  // ─── Нарьян-Мар ───
  RussianStreet(city: 'Нарьян-Мар', street: 'Ленина', lat: 67.6381, lng: 53.0069),
  RussianStreet(city: 'Нарьян-Мар', street: 'Советская', lat: 67.6391, lng: 53.0079),
  RussianStreet(city: 'Нарьян-Мар', street: 'Строителей', lat: 67.6371, lng: 53.0059),

  // ─── Анадырь ───
  RussianStreet(city: 'Анадырь', street: 'Ленина', lat: 64.7333, lng: 177.5000),
  RussianStreet(city: 'Анадырь', street: 'Полярная', lat: 64.7343, lng: 177.5010),
  RussianStreet(city: 'Анадырь', street: 'Мира', lat: 64.7323, lng: 177.4990),

  // ─── Биробиджан ───
  RussianStreet(city: 'Биробиджан', street: 'Ленина', lat: 48.7928, lng: 132.9214),
  RussianStreet(city: 'Биробиджан', street: 'Советская', lat: 48.7938, lng: 132.9224),
  RussianStreet(city: 'Биробиджан', street: 'Шолом-Алейхема', lat: 48.7918, lng: 132.9204),

  // ─── Москва — дополнительные улицы ───
  RussianStreet(city: 'Москва', street: 'Тверская улица', lat: 55.7624, lng: 37.6114),
  RussianStreet(city: 'Москва', street: 'Смоленская', lat: 55.7470, lng: 37.5830),
  RussianStreet(city: 'Москва', street: 'Каширское шоссе', lat: 55.6600, lng: 37.6450),
  RussianStreet(city: 'Москва', street: 'Варшавское шоссе', lat: 55.6380, lng: 37.6220),
  RussianStreet(city: 'Москва', street: 'Ленинградское шоссе', lat: 55.8500, lng: 37.5050),
  RussianStreet(city: 'Москва', street: 'Рязанский проспект', lat: 55.7230, lng: 37.7100),
  RussianStreet(city: 'Москва', street: 'Открытое шоссе', lat: 55.7760, lng: 37.6920),
  RussianStreet(city: 'Москва', street: 'Измайлово', lat: 55.7890, lng: 37.7500),
  RussianStreet(city: 'Москва', street: 'Боровицкая', lat: 55.7500, lng: 37.6080),
  RussianStreet(city: 'Москва', street: 'Столярный переулок', lat: 55.7530, lng: 37.6050),
  RussianStreet(city: 'Москва', street: 'Большая Ордынка', lat: 55.7420, lng: 37.6270),
  RussianStreet(city: 'Москва', street: 'Кропоткинская', lat: 55.7450, lng: 37.6010),
  RussianStreet(city: 'Москва', street: 'Парк Культуры', lat: 55.7320, lng: 37.5900),
  RussianStreet(city: 'Москва', street: 'Фрунзенская', lat: 55.7380, lng: 37.5870),
  RussianStreet(city: 'Москва', street: 'Садовническая', lat: 55.7410, lng: 37.6260),
  RussianStreet(city: 'Москва', street: 'Новинский бульвар', lat: 55.7340, lng: 37.5810),
  RussianStreet(city: 'Москва', street: 'Сущёвский Вал', lat: 55.7780, lng: 37.5960),
  RussianStreet(city: 'Москва', street: 'Большая Лубянка', lat: 55.7620, lng: 37.6280),
  RussianStreet(city: 'Москва', street: 'Малая Лубянка', lat: 55.7630, lng: 37.6300),
  RussianStreet(city: 'Москва', street: 'Мясницкая', lat: 55.7610, lng: 37.6390),

  // ─── Москва — переулки и площади ───
  RussianStreet(city: 'Москва', street: 'Тверской бульвар', lat: 55.7640, lng: 37.5940),
  RussianStreet(city: 'Москва', street: 'Поварская', lat: 55.7560, lng: 37.5920),
  RussianStreet(city: 'Москва', street: 'Спиридоньевский переулок', lat: 55.7670, lng: 37.5920),
  RussianStreet(city: 'Москва', street: 'Столешников переулок', lat: 55.7630, lng: 37.6210),
  RussianStreet(city: 'Москва', street: 'Кузнецкий Мост', lat: 55.7610, lng: 37.6240),
  RussianStreet(city: 'Москва', street: 'Нетка', lat: 55.7600, lng: 37.6220),
  RussianStreet(city: 'Москва', street: 'Ильинка', lat: 55.7560, lng: 37.6330),
  RussianStreet(city: 'Москва', street: 'Маросейка', lat: 55.7580, lng: 37.6490),
  RussianStreet(city: 'Москва', street: 'Покровский бульвар', lat: 55.7580, lng: 37.6520),
  RussianStreet(city: 'Москва', street: 'Чистопрудный бульвар', lat: 55.7640, lng: 37.6410),
  RussianStreet(city: 'Москва', street: 'Бульвар Мира', lat: 55.7730, lng: 37.6310),

  // ─── Москва — юг и запад ───
  RussianStreet(city: 'Москва', street: 'Профсоюзная', lat: 55.6780, lng: 37.5680),
  RussianStreet(city: 'Москва', street: 'Нахимовский проспект', lat: 55.6570, lng: 37.5860),
  RussianStreet(city: 'Москва', street: 'Ул. Академика Пилюгина', lat: 55.6800, lng: 37.5730),
  RussianStreet(city: 'Москва', street: 'Ленинские горы', lat: 55.7020, lng: 37.5350),
  RussianStreet(city: 'Москва', street: 'Сетуньская', lat: 55.7290, lng: 37.5190),
  RussianStreet(city: 'Москва', street: 'Раменки', lat: 55.6950, lng: 37.5010),
  RussianStreet(city: 'Москва', street: 'Мичуринский проспект', lat: 55.6910, lng: 37.5020),

  // ─── Москва — восток ───
  RussianStreet(city: 'Москва', street: 'Андроновская набережная', lat: 55.7440, lng: 37.6930),
  RussianStreet(city: 'Москва', street: 'Нижегородская', lat: 55.7330, lng: 37.7010),
  RussianStreet(city: 'Москва', street: 'Шоссе Энтузиастов', lat: 55.7570, lng: 37.6820),
  RussianStreet(city: 'Москва', street: 'Измайловское шоссе', lat: 55.7890, lng: 37.7500),
  RussianStreet(city: 'Москва', street: 'Средняя Первомайская', lat: 55.7920, lng: 37.7840),
  RussianStreet(city: 'Москва', street: '1-я Владимирская', lat: 55.7600, lng: 37.7080),

  // ─── Москва — север ───
  RussianStreet(city: 'Москва', street: 'Кронштадтский бульвар', lat: 55.7920, lng: 37.5010),
  RussianStreet(city: 'Москва', street: 'Планетная', lat: 55.8080, lng: 37.5250),
  RussianStreet(city: 'Москва', street: 'Клары Цеткин', lat: 55.8250, lng: 37.5190),
  RussianStreet(city: 'Москва', street: 'Сельскохозяйственная', lat: 55.8030, lng: 37.5560),
  RussianStreet(city: 'Москва', street: 'Лихачёвский проспект', lat: 55.7940, lng: 37.5140),
  RussianStreet(city: 'Москва', street: 'Загорьевский проспект', lat: 55.7910, lng: 37.5410),
  RussianStreet(city: 'Москва', street: 'Пятницкое шоссе', lat: 55.8510, lng: 37.4210),

  // ─── Балашиха — дополнительные ───
  RussianStreet(city: 'Балашиха', street: 'Центральная', lat: 55.7415, lng: 37.9450),
  RussianStreet(city: 'Балашиха', street: 'Октябрьская', lat: 55.7405, lng: 37.9440),
  RussianStreet(city: 'Балашиха', street: 'Мичурина', lat: 55.7435, lng: 37.9465),
  RussianStreet(city: 'Балашиха', street: 'Садовая', lat: 55.7425, lng: 37.9455),
  RussianStreet(city: 'Балашиха', street: 'Шоссе Энтузиастов', lat: 55.7445, lng: 37.9475),

  // ─── Химки — дополнительные ───
  RussianStreet(city: 'Химки', street: 'Октябрьская', lat: 55.8930, lng: 37.4330),
  RussianStreet(city: 'Химки', street: 'Мичурина', lat: 55.8970, lng: 37.4375),
  RussianStreet(city: 'Химки', street: 'Бухарестская', lat: 55.8920, lng: 37.4320),
  RussianStreet(city: 'Химки', street: 'Ленинградская', lat: 55.8980, lng: 37.4385),

  // ─── Мытищи — дополнительные ───
  RussianStreet(city: 'Мытищи', street: 'Центральная', lat: 55.9160, lng: 37.7310),
  RussianStreet(city: 'Мытищи', street: 'Советская', lat: 55.9150, lng: 37.7300),
  RussianStreet(city: 'Мытищи', street: 'Колхозная', lat: 55.9170, lng: 37.7320),
  RussianStreet(city: 'Мытищи', street: 'Дачная', lat: 55.9140, lng: 37.7290),

  // ─── Люберцы — дополнительные ───
  RussianStreet(city: 'Люберцы', street: 'Октябрьская', lat: 55.6750, lng: 37.8935),
  RussianStreet(city: 'Люберцы', street: 'Советская', lat: 55.6770, lng: 37.8955),
  RussianStreet(city: 'Люберцы', street: 'Мира', lat: 55.6760, lng: 37.8945),

  // ─── Домодедово — дополнительные ───
  RussianStreet(city: 'Домодедово', street: 'Центральная', lat: 55.4370, lng: 37.7580),
  RussianStreet(city: 'Домодедово', street: 'Советская', lat: 55.4365, lng: 37.7575),

  // ─── Подольск — дополнительные ───
  RussianStreet(city: 'Подольск', street: 'Мира', lat: 55.4295, lng: 37.5530),
  RussianStreet(city: 'Подольск', street: 'Советская', lat: 55.4310, lng: 37.5540),
  RussianStreet(city: 'Подольск', street: 'Октябрьская', lat: 55.4300, lng: 37.5520),

  // ─── Серпухов — дополнительные ───
  RussianStreet(city: 'Серпухов', street: 'Мира', lat: 54.9135, lng: 37.4105),
  RussianStreet(city: 'Серпухов', street: 'Ворошилова', lat: 54.9145, lng: 37.4115),
  RussianStreet(city: 'Серпухов', street: 'Рыбацкая', lat: 54.9130, lng: 37.4100),

  // ─── Одинцово — дополнительные ───
  RussianStreet(city: 'Одинцово', street: 'Мира', lat: 55.6790, lng: 37.2748),
  RussianStreet(city: 'Одинцово', street: 'Советская', lat: 55.6780, lng: 37.2738),

  // ─── Королёв — дополнительные ───
  RussianStreet(city: 'Королёв', street: 'Центральная', lat: 55.9170, lng: 37.8555),
  RussianStreet(city: 'Королёв', street: 'Крымская', lat: 55.9160, lng: 37.8545),
  RussianStreet(city: 'Королёв', street: 'Гагарина', lat: 55.9155, lng: 37.8540),

  // ─── Красногорск — дополнительные ───
  RussianStreet(city: 'Красногорск', street: 'Мира', lat: 55.8200, lng: 37.3310),
  RussianStreet(city: 'Красногорск', street: 'Красногорская', lat: 55.8210, lng: 37.3320),
  RussianStreet(city: 'Красногорск', street: 'Советская', lat: 55.8195, lng: 37.3300),

  // ─── Коломна — дополнительные ───
  RussianStreet(city: 'Коломна', street: 'Мира', lat: 55.0790, lng: 38.7780),
  RussianStreet(city: 'Коломна', street: 'Советская', lat: 55.0800, lng: 38.7790),

  // ─── Ногинск ───
  RussianStreet(city: 'Ногинск', street: 'Ленина', lat: 55.8553, lng: 38.4417),
  RussianStreet(city: 'Ногинск', street: 'Советская', lat: 55.8563, lng: 38.4427),

  // ─── Павловский Посад ───
  RussianStreet(city: 'Павловский Посад', street: 'Ленина', lat: 55.6808, lng: 37.8160),
  RussianStreet(city: 'Павловский Посад', street: 'Мира', lat: 55.6818, lng: 37.8170),

  // ─── Электросталь ───
  RussianStreet(city: 'Электросталь', street: 'Ленина', lat: 55.7908, lng: 38.4475),
  RussianStreet(city: 'Электросталь', street: 'Мира', lat: 55.7918, lng: 38.4485),

  // ─── Жуковский ───
  RussianStreet(city: 'Жуковский', street: 'Гагарина', lat: 55.5996, lng: 38.1183),
  RussianStreet(city: 'Жуковский', street: 'Ленина', lat: 55.6006, lng: 38.1193),
  RussianStreet(city: 'Жуковский', street: 'Центральная', lat: 55.5986, lng: 38.1173),

  // ─── Воскресенск ───
  RussianStreet(city: 'Воскресенск', street: 'Ленина', lat: 55.3173, lng: 38.6633),
  RussianStreet(city: 'Воскресенск', street: 'Советская', lat: 55.3183, lng: 38.6643),

  // ─── Лобня ───
  RussianStreet(city: 'Лобня', street: 'Ленина', lat: 56.0086, lng: 37.4813),
  RussianStreet(city: 'Лобня', street: 'Центральная', lat: 56.0096, lng: 37.4823),

  // ─── Долгопрудный ───
  RussianStreet(city: 'Долгопрудный', street: 'Ленина', lat: 55.9685, lng: 37.5300),
  RussianStreet(city: 'Долгопрудный', street: 'Мира', lat: 55.9695, lng: 37.5310),

  // ─── Реутов ───
  RussianStreet(city: 'Реутов', street: 'Ленина', lat: 55.7567, lng: 37.8570),
  RussianStreet(city: 'Реутов', street: 'Мира', lat: 55.7577, lng: 37.8580),

  // ─── Производственные ───
  RussianStreet(city: 'Москва', street: 'Ленинский проспект', lat: 55.7070, lng: 37.5870),
  RussianStreet(city: 'Москва', street: 'Кутузовский проспект', lat: 55.7410, lng: 37.5620),
  RussianStreet(city: 'Москва', street: 'Кутузовский', lat: 55.7410, lng: 37.5620),
  RussianStreet(city: 'Москва', street: 'Ленинградский', lat: 55.7720, lng: 37.5940),

  // ─── Петербург — дополнительные ───
  RussianStreet(city: 'Санкт-Петербург', street: 'Невский', lat: 59.9350, lng: 30.3270),
  RussianStreet(city: 'Санкт-Петербург', street: 'Пушкинская', lat: 59.9320, lng: 30.3340),
  RussianStreet(city: 'Санкт-Петербург', street: 'Владимирский', lat: 59.9260, lng: 30.3350),
  RussianStreet(city: 'Санкт-Петербург', street: 'Казачий', lat: 59.9280, lng: 30.3220),
  RussianStreet(city: 'Санкт-Петербург', street: 'Литейный', lat: 59.9430, lng: 30.3260),
  RussianStreet(city: 'Санкт-Петербург', street: 'Большой проспект ПС', lat: 59.9380, lng: 30.3150),
  RussianStreet(city: 'Санкт-Петербург', street: 'Каменноостровский', lat: 59.9500, lng: 30.3250),
  RussianStreet(city: 'Санкт-Петербург', street: 'Басков', lat: 59.9330, lng: 30.3310),
  RussianStreet(city: 'Санкт-Петербург', street: 'Маяковского', lat: 59.9340, lng: 30.3320),

  // ─── Екатеринбург — дополнительные ───
  RussianStreet(city: 'Екатеринбург', street: 'Малышева', lat: 56.8357, lng: 60.5957),
  RussianStreet(city: 'Екатеринбург', street: 'проспект Космонавтов', lat: 56.8400, lng: 60.6067),
  RussianStreet(city: 'Екатеринбург', street: 'Белинского', lat: 56.8370, lng: 60.6030),
  RussianStreet(city: 'Екатеринбург', street: 'Куйбышева', lat: 56.8360, lng: 60.6010),
  RussianStreet(city: 'Екатеринбург', street: 'Радищева', lat: 56.8375, lng: 60.6045),
  RussianStreet(city: 'Екатеринбург', street: 'Шверника', lat: 56.8350, lng: 60.5990),
  RussianStreet(city: 'Екатеринбург', street: '8 Марта', lat: 56.8340, lng: 60.5940),
  RussianStreet(city: 'Екатеринбург', street: 'Ползунова', lat: 56.8385, lng: 60.6055),

  // ─── Казань — дополнительные ───
  RussianStreet(city: 'Казань', street: 'Баумана', lat: 55.7887, lng: 49.1221),
  RussianStreet(city: 'Казань', street: 'Кремлёвская', lat: 55.7970, lng: 49.1120),
  RussianStreet(city: 'Казань', street: 'Университетская', lat: 55.7900, lng: 49.1190),
  RussianStreet(city: 'Казань', street: 'Пушкина', lat: 55.7877, lng: 49.1211),
  RussianStreet(city: 'Казань', street: 'Чернышевского', lat: 55.7857, lng: 49.1241),
  RussianStreet(city: 'Казань', street: 'Островского', lat: 55.7837, lng: 49.1261),

  // ─── Нижний Новгород — дополнительные ───
  RussianStreet(city: 'Нижний Новгород', street: 'Большая Покровская', lat: 56.2965, lng: 43.9361),
  RussianStreet(city: 'Нижний Новгород', street: 'Большая Дмитриевская', lat: 56.2975, lng: 43.9371),
  RussianStreet(city: 'Нижний Новгород', street: 'Рождественская', lat: 56.2955, lng: 43.9351),

  // ─── Челябинск — дополнительные ───
  RussianStreet(city: 'Челябинск', street: 'Кировка', lat: 55.1644, lng: 61.4368),
  RussianStreet(city: 'Челябинск', street: 'Мира', lat: 55.1634, lng: 61.4358),
  RussianStreet(city: 'Челябинск', street: 'Труда', lat: 55.1624, lng: 61.4348),
  RussianStreet(city: 'Челябинск', street: 'Гагарина', lat: 55.1674, lng: 61.4398),
  RussianStreet(city: 'Челябинск', street: 'Советская', lat: 55.1664, lng: 61.4388),

  // ─── Самара — дополнительные ───
  RussianStreet(city: 'Самара', street: 'Московская', lat: 53.1969, lng: 50.1012),
  RussianStreet(city: 'Самара', street: 'Чапаевская', lat: 53.1949, lng: 50.0992),
  RussianStreet(city: 'Самара', street: 'Красноармейская', lat: 53.1979, lng: 50.1022),
  RussianStreet(city: 'Самара', street: 'Галактионовская', lat: 53.1939, lng: 50.0982),

  // ─── Воронеж — дополнительные ───
  RussianStreet(city: 'Воронеж', street: 'Кольцовская', lat: 51.6720, lng: 39.1843),
  RussianStreet(city: 'Воронеж', street: 'Плехановская', lat: 51.6730, lng: 39.1853),
  RussianStreet(city: 'Воронеж', street: 'Ворошилова', lat: 51.6710, lng: 39.1833),
  RussianStreet(city: 'Воронеж', street: '9 Января', lat: 51.6740, lng: 39.1863),

  // ─── Краснодар — дополнительные ───
  RussianStreet(city: 'Краснодар', street: 'Красная', lat: 45.0355, lng: 38.9753),
  RussianStreet(city: 'Краснодар', street: 'Длинная', lat: 45.0365, lng: 38.9763),
  RussianStreet(city: 'Краснодар', street: 'Северная', lat: 45.0345, lng: 38.9743),
  RussianStreet(city: 'Краснодар', street: 'Западная', lat: 45.0375, lng: 38.9773),
  RussianStreet(city: 'Краснодар', street: 'Мира', lat: 45.0335, lng: 38.9733),

  // ─── Ростов-на-Дону — дополнительные ───
  RussianStreet(city: 'Ростов-на-Дону', street: 'Большая Садовая', lat: 47.2357, lng: 39.7015),
  RussianStreet(city: 'Ростов-на-Дону', street: 'Пушкинская', lat: 47.2367, lng: 39.7025),
  RussianStreet(city: 'Ростов-на-Дону', street: 'Советская', lat: 47.2347, lng: 39.7005),
  RussianStreet(city: 'Ростов-на-Дону', street: 'Ленина', lat: 47.2377, lng: 39.7035),
];
