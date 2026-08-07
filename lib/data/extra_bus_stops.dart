import 'russian_bus_stops.dart';

const List<BusStop> extraBusStops = [
  // ========== МОСКОВСКАЯ ОБЛАСТЬ ==========
  BusStop(
    id: 'msk_mo_001',
    name: 'Река Пахра',
    city: 'Московская область',
    district: 'Подольский район',
    lat: 55.4297,
    lng: 37.5444,
    routes: [
      BusRoute(number: '405', direction: 'Река Пахра - Подольск', frequencyMinutes: 15, firstBus: '06:00', lastBus: '23:00'),
      BusRoute(number: '1042', direction: 'Река Пахра - Марьино', frequencyMinutes: 20, firstBus: '05:30', lastBus: '22:30'),
      BusRoute(number: '464', direction: 'Подольск - Река Пахра', frequencyMinutes: 15, firstBus: '06:00', lastBus: '23:00'),
    ],
  ),
  BusStop(
    id: 'msk_mo_002',
    name: 'Подольск автовокзал',
    city: 'Московская область',
    district: 'Подольск',
    lat: 55.4250,
    lng: 37.5531,
    routes: [
      BusRoute(number: '405', direction: 'Подольск - Река Пахра', frequencyMinutes: 15, firstBus: '06:00', lastBus: '23:00'),
      BusRoute(number: '1042', direction: 'Подольск - Марьино', frequencyMinutes: 20, firstBus: '05:30', lastBus: '22:30'),
      BusRoute(number: '1044', direction: 'Подольск - Центральная', frequencyMinutes: 12, firstBus: '05:45', lastBus: '23:15'),
      BusRoute(number: '464', direction: 'Подольск - Река Пахра', frequencyMinutes: 15, firstBus: '06:00', lastBus: '23:00'),
    ],
  ),
  BusStop(
    id: 'msk_mo_003',
    name: 'Химки автовокзал',
    city: 'Московская область',
    district: 'Химки',
    lat: 55.8961,
    lng: 37.4297,
    routes: [
      BusRoute(number: '370', direction: 'Химки - МТК', frequencyMinutes: 10, firstBus: '05:30', lastBus: '23:30'),
      BusRoute(number: '400', direction: 'Химки - Ленинградский вокзал', frequencyMinutes: 8, firstBus: '05:00', lastBus: '00:30'),
      BusRoute(number: '468', direction: 'Химки - Сходня', frequencyMinutes: 20, firstBus: '06:00', lastBus: '22:00'),
    ],
  ),
  BusStop(
    id: 'msk_mo_004',
    name: 'Мытищи жд станция',
    city: 'Московская область',
    district: 'Мытищи',
    lat: 55.9100,
    lng: 37.7356,
    routes: [
      BusRoute(number: '321', direction: 'Мытищи - Оstashkovo', frequencyMinutes: 15, firstBus: '06:00', lastBus: '23:00'),
      BusRoute(number: '399', direction: 'Мытищи - Ярославский вокзал', frequencyMinutes: 10, firstBus: '05:30', lastBus: '23:30'),
      BusRoute(number: '430', direction: 'Мытищи - Пирочи', frequencyMinutes: 25, firstBus: '06:00', lastBus: '21:30'),
    ],
  ),
  BusStop(
    id: 'msk_mo_005',
    name: 'Одинцово жд станция',
    city: 'Московская область',
    district: 'Одинцово',
    lat: 55.6778,
    lng: 37.2778,
    routes: [
      BusRoute(number: '372', direction: 'Одинцово - Славянский бульвар', frequencyMinutes: 12, firstBus: '05:30', lastBus: '23:30'),
      BusRoute(number: '442', direction: 'Одинцово - Молодёжная', frequencyMinutes: 15, firstBus: '06:00', lastBus: '23:00'),
    ],
  ),
  BusStop(
    id: 'msk_mo_006',
    name: 'Балашиха микрорайон Жуковский',
    city: 'Московская область',
    district: 'Балашиха',
    lat: 55.7333,
    lng: 37.9333,
    routes: [
      BusRoute(number: '323', direction: 'Балашиха - Щёлковская', frequencyMinutes: 12, firstBus: '05:30', lastBus: '23:00'),
      BusRoute(number: '332', direction: 'Балашиха - Новогиреево', frequencyMinutes: 15, firstBus: '06:00', lastBus: '22:30'),
    ],
  ),
  BusStop(
    id: 'msk_mo_007',
    name: 'Люберцы центр',
    city: 'Московская область',
    district: 'Люберцы',
    lat: 55.6764,
    lng: 37.8939,
    routes: [
      BusRoute(number: '348', direction: 'Люберцы - Выхино', frequencyMinutes: 15, firstBus: '06:00', lastBus: '23:00'),
      BusRoute(number: '349', direction: 'Люберцы - Тёплый Стан', frequencyMinutes: 20, firstBus: '06:00', lastBus: '22:00'),
    ],
  ),
  BusStop(
    id: 'msk_mo_008',
    name: 'Красногорск центр',
    city: 'Московская область',
    district: 'Красногорск',
    lat: 55.8197,
    lng: 37.3297,
    routes: [
      BusRoute(number: '372', direction: 'Красногорск - Одинцово', frequencyMinutes: 15, firstBus: '06:00', lastBus: '23:00'),
      BusRoute(number: '400', direction: 'Красногорск - Химки', frequencyMinutes: 20, firstBus: '06:00', lastBus: '22:00'),
      BusRoute(number: '402', direction: 'Красногорск - Строгино', frequencyMinutes: 12, firstBus: '05:45', lastBus: '23:15'),
    ],
  ),
  BusStop(
    id: 'msk_mo_009',
    name: 'Пушкино жд станция',
    city: 'Московская область',
    district: 'Пушкино',
    lat: 56.0108,
    lng: 37.8475,
    routes: [
      BusRoute(number: '338', direction: 'Пушкино - Ярославский вокзал', frequencyMinutes: 12, firstBus: '05:30', lastBus: '23:30'),
      BusRoute(number: '380', direction: 'Пушкино - Калино', frequencyMinutes: 25, firstBus: '06:00', lastBus: '21:30'),
    ],
  ),
  BusStop(
    id: 'msk_mo_010',
    name: 'Домодедово аэропорт',
    city: 'Московская область',
    district: 'Домодедово',
    lat: 55.4086,
    lng: 37.9064,
    routes: [
      BusRoute(number: '404', direction: 'Домодедово - Аннино', frequencyMinutes: 15, firstBus: '05:00', lastBus: '01:00'),
      BusRoute(number: '443', direction: 'Домодедово - Домодедовская', frequencyMinutes: 10, firstBus: '05:00', lastBus: '01:00'),
      BusRoute(number: '505', direction: 'Домодедово - Каширская', frequencyMinutes: 15, firstBus: '05:30', lastBus: '00:30'),
    ],
  ),
  BusStop(
    id: 'msk_mo_011',
    name: 'Наро-Фоминск центр',
    city: 'Московская область',
    district: 'Наро-Фоминск',
    lat: 55.3867,
    lng: 36.7333,
    routes: [
      BusRoute(number: '1028', direction: 'Наро-Фоминск - Москва', frequencyMinutes: 20, firstBus: '05:30', lastBus: '22:30'),
      BusRoute(number: '1029', direction: 'Наро-Фоминск - Бородино', frequencyMinutes: 30, firstBus: '06:00', lastBus: '21:00'),
    ],
  ),
  BusStop(
    id: 'msk_mo_012',
    name: 'Серпухов автовокзал',
    city: 'Московская область',
    district: 'Серпухов',
    lat: 54.9167,
    lng: 37.4000,
    routes: [
      BusRoute(number: '1030', direction: 'Серпухов - Москва', frequencyMinutes: 20, firstBus: '05:00', lastBus: '23:00'),
      BusRoute(number: '1031', direction: 'Серпухов - Венёв', frequencyMinutes: 30, firstBus: '06:00', lastBus: '21:00'),
      BusRoute(number: '1032', direction: 'Серпухов - Протвино', frequencyMinutes: 25, firstBus: '06:00', lastBus: '22:00'),
    ],
  ),
  BusStop(
    id: 'msk_mo_013',
    name: 'Щёлково центр',
    city: 'Московская область',
    district: 'Щёлково',
    lat: 55.9167,
    lng: 37.9833,
    routes: [
      BusRoute(number: '380', direction: 'Щёлково - Балашиха', frequencyMinutes: 15, firstBus: '06:00', lastBus: '23:00'),
      BusRoute(number: '332', direction: 'Щёлково - Новогиреево', frequencyMinutes: 12, firstBus: '05:30', lastBus: '23:00'),
    ],
  ),
  BusStop(
    id: 'msk_mo_014',
    name: 'Электросталь центр',
    city: 'Московская область',
    district: 'Электросталь',
    lat: 55.7833,
    lng: 38.4333,
    routes: [
      BusRoute(number: '319', direction: 'Электросталь - Ногинск', frequencyMinutes: 20, firstBus: '06:00', lastBus: '22:00'),
      BusRoute(number: '340', direction: 'Электросталь - Щёлково', frequencyMinutes: 25, firstBus: '06:00', lastBus: '21:30'),
    ],
  ),
  BusStop(
    id: 'msk_mo_015',
    name: 'Коломна автовокзал',
    city: 'Московская область',
    district: 'Коломна',
    lat: 55.0833,
    lng: 38.7833,
    routes: [
      BusRoute(number: '1035', direction: 'Коломна - Москва', frequencyMinutes: 25, firstBus: '05:00', lastBus: '22:30'),
      BusRoute(number: '1036', direction: 'Коломна - Раменское', frequencyMinutes: 30, firstBus: '06:00', lastBus: '21:00'),
    ],
  ),

  // ========== ЛЕНИНГРАДСКАЯ ОБЛАСТЬ ==========
  BusStop(
    id: 'spb_lo_001',
    name: 'Павловск жд станция',
    city: 'Ленинградская область',
    district: 'Павловск',
    lat: 59.6833,
    lng: 30.4333,
    routes: [
      BusRoute(number: '381', direction: 'Павловск - Витебский вокзал', frequencyMinutes: 12, firstBus: '05:30', lastBus: '23:30'),
      BusRoute(number: '382', direction: 'Павловск - Гатчина', frequencyMinutes: 20, firstBus: '06:00', lastBus: '22:00'),
    ],
  ),
  BusStop(
    id: 'spb_lo_002',
    name: 'Гатчина автовокзал',
    city: 'Ленинградская область',
    district: 'Гатчина',
    lat: 59.5764,
    lng: 30.1286,
    routes: [
      BusRoute(number: '431', direction: 'Гатчина - Москва', frequencyMinutes: 20, firstBus: '05:30', lastBus: '23:00'),
      BusRoute(number: '432', direction: 'Гатчина - Кингисепп', frequencyMinutes: 25, firstBus: '06:00', lastBus: '21:30'),
      BusRoute(number: '433', direction: 'Гатчина - Луга', frequencyMinutes: 30, firstBus: '06:00', lastBus: '21:00'),
    ],
  ),
  BusStop(
    id: 'spb_lo_003',
    name: 'Выборг автовокзал',
    city: 'Ленинградская область',
    district: 'Выборг',
    lat: 60.7103,
    lng: 28.7464,
    routes: [
      BusRoute(number: '815', direction: 'Выборг - Москва', frequencyMinutes: 20, firstBus: '05:30', lastBus: '23:00'),
      BusRoute(number: '816', direction: 'Выборг - Каменногорск', frequencyMinutes: 30, firstBus: '06:00', lastBus: '21:00'),
      BusRoute(number: '817', direction: 'Выборг - Высоцк', frequencyMinutes: 40, firstBus: '06:30', lastBus: '20:30'),
    ],
  ),
  BusStop(
    id: 'spb_lo_004',
    name: 'Кингисепп автовокзал',
    city: 'Ленинградская область',
    district: 'Кингисепп',
    lat: 59.3736,
    lng: 28.6136,
    routes: [
      BusRoute(number: '432', direction: 'Кингисепп - Гатчина', frequencyMinutes: 25, firstBus: '06:00', lastBus: '21:30'),
      BusRoute(number: '808', direction: 'Кингисепп - Москва', frequencyMinutes: 30, firstBus: '06:00', lastBus: '21:00'),
    ],
  ),
  BusStop(
    id: 'spb_lo_005',
    name: 'Луга автовокзал',
    city: 'Ленинградская область',
    district: 'Луга',
    lat: 58.7333,
    lng: 29.8500,
    routes: [
      BusRoute(number: '433', direction: 'Луга - Гатчина', frequencyMinutes: 30, firstBus: '06:00', lastBus: '21:00'),
      BusRoute(number: '820', direction: 'Луга - Москва', frequencyMinutes: 35, firstBus: '06:00', lastBus: '20:30'),
    ],
  ),

  // ========== МОСКВА (дополнения) ==========
  BusStop(
    id: 'msk_extra_001',
    name: 'Центральная автобусная станция',
    city: 'Москва',
    district: 'Новогиреево',
    lat: 55.7503,
    lng: 37.8203,
    routes: [
      BusRoute(number: '614', direction: 'КАД Восток', frequencyMinutes: 10, firstBus: '05:00', lastBus: '01:00'),
      BusRoute(number: '615', direction: 'Новогиреево', frequencyMinutes: 15, firstBus: '05:30', lastBus: '23:30'),
    ],
  ),
  BusStop(
    id: 'msk_extra_002',
    name: 'Мичуринский проспект',
    city: 'Москва',
    district: 'Проспект Вернадского',
    lat: 55.6917,
    lng: 37.5167,
    routes: [
      BusRoute(number: '652', direction: 'Мичуринский пр - Кунцевская', frequencyMinutes: 12, firstBus: '05:30', lastBus: '23:00'),
      BusRoute(number: '660', direction: 'Мичуринский пр - Славянский бульвар', frequencyMinutes: 15, firstBus: '06:00', lastBus: '23:00'),
    ],
  ),
  BusStop(
    id: 'msk_extra_003',
    name: 'Бутырская улица',
    city: 'Москва',
    district: 'Савёловский',
    lat: 55.8083,
    lng: 37.5833,
    routes: [
      BusRoute(number: '72', direction: 'Бутырская - Динамо', frequencyMinutes: 8, firstBus: '05:30', lastBus: '00:30'),
      BusRoute(number: '78', direction: 'Бутырская - Тёплый Стан', frequencyMinutes: 10, firstBus: '05:30', lastBus: '00:00'),
    ],
  ),
  BusStop(
    id: 'msk_extra_004',
    name: 'Ломоносовский проспект',
    city: 'Москва',
    district: 'Гагаринский',
    lat: 55.6917,
    lng: 37.5333,
    routes: [
      BusRoute(number: '111', direction: 'Ломоносовский пр - Автозаводская', frequencyMinutes: 8, firstBus: '05:30', lastBus: '00:30'),
      BusRoute(number: '113', direction: 'Ломоносовский пр - Шаболовская', frequencyMinutes: 10, firstBus: '05:30', lastBus: '00:00'),
    ],
  ),
  BusStop(
    id: 'msk_extra_005',
    name: 'Пятницкое шоссе',
    city: 'Москва',
    district: 'Митино',
    lat: 55.8500,
    lng: 37.3667,
    routes: [
      BusRoute(number: '568', direction: 'Пятницкое шоссе - Митино', frequencyMinutes: 8, firstBus: '05:00', lastBus: '01:00'),
      BusRoute(number: '575', direction: 'Пятницкое шоссе - Тушино', frequencyMinutes: 12, firstBus: '05:30', lastBus: '23:30'),
    ],
  ),
  BusStop(
    id: 'msk_extra_006',
    name: 'Ленинский проспект',
    city: 'Москва',
    district: 'Ленинский',
    lat: 55.7083,
    lng: 37.5667,
    routes: [
      BusRoute(number: '111', direction: 'Ленинский пр - Варшавское ш.', frequencyMinutes: 8, firstBus: '05:30', lastBus: '00:30'),
      BusRoute(number: '196', direction: 'Ленинский пр - Краснопресненская', frequencyMinutes: 10, firstBus: '05:30', lastBus: '00:00'),
    ],
  ),

  // ========== ПЕТЕРБУРГ (дополнения) ==========
  BusStop(
    id: 'spb_extra_001',
    name: 'Петроградская набережная',
    city: 'Санкт-Петербург',
    district: 'Петроградский',
    lat: 59.9500,
    lng: 30.3167,
    routes: [
      BusRoute(number: '49', direction: 'Петроградская - Сенная', frequencyMinutes: 8, firstBus: '05:30', lastBus: '00:30'),
      BusRoute(number: '107', direction: 'Петроградская - Автово', frequencyMinutes: 10, firstBus: '05:30', lastBus: '00:00'),
    ],
  ),
  BusStop(
    id: 'spb_extra_002',
    name: 'Комендантский проспект',
    city: 'Санкт-Петербург',
    district: 'Калининский',
    lat: 60.0083,
    lng: 30.2500,
    routes: [
      BusRoute(number: '76', direction: 'Комендантский пр - Московский вокзал', frequencyMinutes: 8, firstBus: '05:30', lastBus: '00:30'),
      BusRoute(number: '177', direction: 'Комендантский пр - Садовая', frequencyMinutes: 10, firstBus: '05:30', lastBus: '00:00'),
    ],
  ),
  BusStop(
    id: 'spb_extra_003',
    name: 'Приморская',
    city: 'Санкт-Петербург',
    district: 'Василеостровский',
    lat: 59.9483,
    lng: 30.2750,
    routes: [
      BusRoute(number: '49', direction: 'Приморская - Торжковская', frequencyMinutes: 8, firstBus: '05:30', lastBus: '00:30'),
      BusRoute(number: '152', direction: 'Приморская - Гостиный двор', frequencyMinutes: 10, firstBus: '06:00', lastBus: '23:30'),
    ],
  ),

  // ========== НОВОСИБИРСК ==========
  BusStop(
    id: 'nsk_extra_001',
    name: 'Академгородок',
    city: 'Новосибирск',
    district: 'Научный городок',
    lat: 54.8500,
    lng: 83.0000,
    routes: [
      BusRoute(number: '1044', direction: 'Академгородок - Сибирский Круг', frequencyMinutes: 10, firstBus: '05:30', lastBus: '00:30'),
      BusRoute(number: '1035', direction: 'Академгородок - площадь Маркса', frequencyMinutes: 12, firstBus: '05:30', lastBus: '23:30'),
    ],
  ),
  BusStop(
    id: 'nsk_extra_002',
    name: 'ГЛавный вокзал',
    city: 'Новосибирск',
    district: 'Центральный',
    lat: 55.0283,
    lng: 82.9264,
    routes: [
      BusRoute(number: '1002', direction: 'Вокзал - Академгородок', frequencyMinutes: 10, firstBus: '05:00', lastBus: '01:00'),
      BusRoute(number: '1011', direction: 'Вокзал - Ленинский мкр', frequencyMinutes: 8, firstBus: '05:00', lastBus: '01:00'),
      BusRoute(number: '1017', direction: 'Вокзал - Кольцовая', frequencyMinutes: 12, firstBus: '05:30', lastBus: '00:30'),
    ],
  ),
  BusStop(
    id: 'nsk_extra_003',
    name: 'Кольцовая',
    city: 'Новосибирск',
    district: 'Дзержинский',
    lat: 55.0500,
    lng: 82.9833,
    routes: [
      BusRoute(number: '1017', direction: 'Кольцовая - Вокзал', frequencyMinutes: 12, firstBus: '05:30', lastBus: '00:30'),
      BusRoute(number: '1025', direction: 'Кольцовая - Северный мкр', frequencyMinutes: 15, firstBus: '06:00', lastBus: '23:00'),
    ],
  ),

  // ========== ЕКАТЕРИНБУРГ ==========
  BusStop(
    id: 'ekb_extra_001',
    name: 'УрФУ',
    city: 'Екатеринбург',
    district: 'Втузгородок',
    lat: 56.8389,
    lng: 60.6614,
    routes: [
      BusRoute(number: '029', direction: 'УрФУ - Втузгородок', frequencyMinutes: 10, firstBus: '05:30', lastBus: '23:30'),
      BusRoute(number: '041', direction: 'УрФУ - Центр', frequencyMinutes: 12, firstBus: '05:30', lastBus: '23:00'),
    ],
  ),
  BusStop(
    id: 'ekb_extra_002',
    name: 'Екатеринбург-Сортировочный',
    city: 'Екатеринбург',
    district: 'ЖБИ',
    lat: 56.8167,
    lng: 60.6333,
    routes: [
      BusRoute(number: '030', direction: 'Сортировочная - Центр', frequencyMinutes: 10, firstBus: '05:30', lastBus: '23:00'),
      BusRoute(number: '031', direction: 'Сортировочная - Химмаш', frequencyMinutes: 12, firstBus: '06:00', lastBus: '22:30'),
    ],
  ),
  BusStop(
    id: 'ekb_extra_003',
    name: 'Академическая',
    city: 'Екатеринбург',
    district: 'Академический',
    lat: 56.8500,
    lng: 60.6333,
    routes: [
      BusRoute(number: '009', direction: 'Академическая - УрФУ', frequencyMinutes: 10, firstBus: '06:00', lastBus: '23:00'),
      BusRoute(number: '020', direction: 'Академическая - Центр', frequencyMinutes: 12, firstBus: '05:30', lastBus: '23:00'),
    ],
  ),

  // ========== КАЗАНЬ ==========
  BusStop(
    id: 'kzn_extra_001',
    name: 'Улица Космонавтов',
    city: 'Казань',
    district: 'Приволжский',
    lat: 55.7833,
    lng: 49.1833,
    routes: [
      BusRoute(number: '34', direction: 'ул. Космонавтов - Казань-1', frequencyMinutes: 10, firstBus: '05:30', lastBus: '23:30'),
      BusRoute(number: '45', direction: 'ул. Космонавтов - СНТ', frequencyMinutes: 12, firstBus: '06:00', lastBus: '22:30'),
    ],
  ),
  BusStop(
    id: 'kzn_extra_002',
    name: 'Площадь Тысячелетия',
    city: 'Казань',
    district: 'Вахитовский',
    lat: 55.7964,
    lng: 49.1083,
    routes: [
      BusRoute(number: '1', direction: 'Пл. Тысячелетия - ОЗНА', frequencyMinutes: 8, firstBus: '05:30', lastBus: '00:30'),
      BusRoute(number: '6', direction: 'Пл. Тысячелетия - Салават Юлаев', frequencyMinutes: 10, firstBus: '05:30', lastBus: '00:00'),
    ],
  ),

  // ========== НИЖНИЙ НОВГОРОД ==========
  BusStop(
    id: 'nnv_extra_001',
    name: 'Стрелка',
    city: 'Нижний Новгород',
    district: 'Нижегородский',
    lat: 56.3264,
    lng: 44.0064,
    routes: [
      BusRoute(number: '36', direction: 'Стрелка - Автозаводская', frequencyMinutes: 10, firstBus: '05:30', lastBus: '23:00'),
      BusRoute(number: '52', direction: 'Стрелка - Московский вокзал', frequencyMinutes: 12, firstBus: '05:30', lastBus: '23:00'),
    ],
  ),
  BusStop(
    id: 'nnv_extra_002',
    name: 'Московский вокзал',
    city: 'Нижний Новгород',
    district: 'Канавинский',
    lat: 56.3264,
    lng: 43.9444,
    routes: [
      BusRoute(number: '36', direction: 'Вокзал - Стрелка', frequencyMinutes: 10, firstBus: '05:30', lastBus: '23:00'),
      BusRoute(number: '41', direction: 'Вокзал - Заречная', frequencyMinutes: 8, firstBus: '05:00', lastBus: '01:00'),
      BusRoute(number: '52', direction: 'Вокзал - Стрелка', frequencyMinutes: 12, firstBus: '05:30', lastBus: '23:00'),
    ],
  ),

  // ========== САМАРА ==========
  BusStop(
    id: 'sam_extra_001',
    name: 'Жигулёвская долина',
    city: 'Самара',
    district: 'Октябрьский',
    lat: 53.1833,
    lng: 50.1000,
    routes: [
      BusRoute(number: '32', direction: 'Жигулёвская долина - Кировский', frequencyMinutes: 10, firstBus: '05:30', lastBus: '23:00'),
      BusRoute(number: '44', direction: 'Жигулёвская долина - Промышленная', frequencyMinutes: 12, firstBus: '06:00', lastBus: '22:30'),
    ],
  ),
  BusStop(
    id: 'sam_extra_002',
    name: 'Самара-Центральная',
    city: 'Самара',
    district: 'Железнодорожный',
    lat: 53.2000,
    lng: 50.1500,
    routes: [
      BusRoute(number: '32', direction: 'Центральная - Жигулёвская', frequencyMinutes: 10, firstBus: '05:30', lastBus: '23:00'),
      BusRoute(number: '60', direction: 'Центральная - Кировский', frequencyMinutes: 12, firstBus: '05:30', lastBus: '23:00'),
    ],
  ),

  // ========== ЧЕЛЯБИНСК ==========
  BusStop(
    id: 'chb_extra_001',
    name: 'Челябинск-Главный',
    city: 'Челябинск',
    district: 'Центральный',
    lat: 55.1500,
    lng: 61.3667,
    routes: [
      BusRoute(number: '1', direction: 'Вокзал - ТРК Пионер', frequencyMinutes: 8, firstBus: '05:30', lastBus: '00:30'),
      BusRoute(number: '12', direction: 'Вокзал - Ленинский', frequencyMinutes: 10, firstBus: '05:30', lastBus: '23:00'),
      BusRoute(number: '73', direction: 'Вокзал - Микрорайон Гранитный', frequencyMinutes: 12, firstBus: '06:00', lastBus: '22:00'),
    ],
  ),

  // ========== УФА ==========
  BusStop(
    id: 'ufa_extra_001',
    name: 'Уфа-Центральная',
    city: 'Уфа',
    district: 'Ленинский',
    lat: 54.7333,
    lng: 55.9500,
    routes: [
      BusRoute(number: '4', direction: 'Центральная - Сипайлово', frequencyMinutes: 8, firstBus: '05:30', lastBus: '00:30'),
      BusRoute(number: '77', direction: 'Центральная - Орехово', frequencyMinutes: 10, firstBus: '05:30', lastBus: '23:00'),
      BusRoute(number: '205', direction: 'Центральная - Космонавт', frequencyMinutes: 12, firstBus: '06:00', lastBus: '22:00'),
    ],
  ),

  // ========== КРАСНОДАР ==========
  BusStop(
    id: 'krd_extra_001',
    name: 'Краснодар автовокзал',
    city: 'Краснодар',
    district: 'Центральный',
    lat: 45.0333,
    lng: 38.9667,
    routes: [
      BusRoute(number: '36', direction: 'Автовокзал - Комсомольский', frequencyMinutes: 10, firstBus: '05:00', lastBus: '23:00'),
      BusRoute(number: '62', direction: 'Автовокзал - ЮБК', frequencyMinutes: 12, firstBus: '05:30', lastBus: '22:30'),
      BusRoute(number: '522', direction: 'Автовокзал - Сочи', frequencyMinutes: 25, firstBus: '06:00', lastBus: '21:00'),
    ],
  ),
  BusStop(
    id: 'krd_extra_002',
    name: 'Улица Красная',
    city: 'Краснодар',
    district: 'Центральный',
    lat: 45.0333,
    lng: 38.9833,
    routes: [
      BusRoute(number: '36', direction: 'ул. Красная - Комсомольский', frequencyMinutes: 10, firstBus: '05:00', lastBus: '23:00'),
      BusRoute(number: '33', direction: 'ул. Красная - Кущёвская', frequencyMinutes: 15, firstBus: '05:30', lastBus: '22:00'),
    ],
  ),

  // ========== РОСТОВ-НА-ДОНУ ==========
  BusStop(
    id: 'rnd_extra_001',
    name: 'Ростов-Главный',
    city: 'Ростов-на-Дону',
    district: 'Центральный',
    lat: 47.2264,
    lng: 39.7264,
    routes: [
      BusRoute(number: '17', direction: 'Вокзал - Хлебозавод', frequencyMinutes: 10, firstBus: '05:30', lastBus: '23:00'),
      BusRoute(number: '26', direction: 'Вокзал - Каменка', frequencyMinutes: 12, firstBus: '05:30', lastBus: '22:30'),
      BusRoute(number: '39', direction: 'Вокзал - Сельмаш', frequencyMinutes: 15, firstBus: '06:00', lastBus: '22:00'),
    ],
  ),

  // ========== ВОЛГОГРАД ==========
  BusStop(
    id: 'vlg_extra_001',
    name: 'Волгоград-1',
    city: 'Волгоград',
    district: 'Центральный',
    lat: 48.7083,
    lng: 44.5167,
    routes: [
      BusRoute(number: '6', direction: 'Волгоград-1 - Тракторный', frequencyMinutes: 10, firstBus: '05:30', lastBus: '23:00'),
      BusRoute(number: '34', direction: 'Волгоград-1 - Красноармейский', frequencyMinutes: 12, firstBus: '05:30', lastBus: '22:30'),
      BusRoute(number: '85', direction: 'Волгоград-1 - Баррикадная', frequencyMinutes: 15, firstBus: '06:00', lastBus: '22:00'),
    ],
  ),

  // ========== СОЧИ ==========
  BusStop(
    id: 'sochi_extra_001',
    name: 'Сочи жд вокзал',
    city: 'Сочи',
    district: 'Центральный',
    lat: 43.5953,
    lng: 39.7233,
    routes: [
      BusRoute(number: '39', direction: 'Вокзал - Имеретинский', frequencyMinutes: 10, firstBus: '05:00', lastBus: '01:00'),
      BusRoute(number: '73', direction: 'Вокзал - Бешеновка', frequencyMinutes: 12, firstBus: '05:30', lastBus: '00:30'),
      BusRoute(number: '105', direction: 'Вокзал - Адлер', frequencyMinutes: 15, firstBus: '05:00', lastBus: '00:30'),
    ],
  ),

  // ========== ТЮМЕНЬ ==========
  BusStop(
    id: 'tyu_extra_001',
    name: 'Тюмень автовокзал',
    city: 'Тюмень',
    district: 'Центральный',
    lat: 57.1500,
    lng: 65.5333,
    routes: [
      BusRoute(number: '1', direction: 'Автовокзал - Войновка', frequencyMinutes: 8, firstBus: '05:30', lastBus: '00:30'),
      BusRoute(number: '14', direction: 'Автовокзал - МЖК', frequencyMinutes: 10, firstBus: '05:30', lastBus: '23:00'),
      BusRoute(number: '38', direction: 'Автовокзал - Ямальская', frequencyMinutes: 12, firstBus: '06:00', lastBus: '22:00'),
    ],
  ),

  // ========== ВЛАДИВОСТОК ==========
  BusStop(
    id: 'vvo_extra_001',
    name: 'Владивосток жд вокзал',
    city: 'Владивосток',
    district: 'Центральный',
    lat: 43.1167,
    lng: 131.8833,
    routes: [
      BusRoute(number: '12', direction: 'Вокзал - ФedList', frequencyMinutes: 10, firstBus: '05:30', lastBus: '23:00'),
      BusRoute(number: '39', direction: 'Вокзал - Сахарная головка', frequencyMinutes: 15, firstBus: '06:00', lastBus: '22:00'),
    ],
  ),

  // ========== ИРКУТСК ==========
  BusStop(
    id: 'irk_extra_001',
    name: 'Иркутск-ГЛАвный',
    city: 'Иркутск',
    district: 'Центральный',
    lat: 52.2933,
    lng: 104.2800,
    routes: [
      BusRoute(number: '4', direction: 'Вокзал - БГУ', frequencyMinutes: 10, firstBus: '05:30', lastBus: '23:00'),
      BusRoute(number: '13', direction: 'Вокзал - Студгородок', frequencyMinutes: 12, firstBus: '05:30', lastBus: '22:30'),
      BusRoute(number: '52', direction: 'Вокзал - ОГМ', frequencyMinutes: 15, firstBus: '06:00', lastBus: '22:00'),
    ],
  ),

  // ========== КРАСНОЯРСК ==========
  BusStop(
    id: 'krs_extra_001',
    name: 'Красноярск жд вокзал',
    city: 'Красноярск',
    district: 'Центральный',
    lat: 56.0133,
    lng: 92.8264,
    routes: [
      BusRoute(number: '6', direction: 'Вокзал - Аэопорт', frequencyMinutes: 10, firstBus: '05:30', lastBus: '23:00'),
      BusRoute(number: '11', direction: 'Вокзал - Северный', frequencyMinutes: 12, firstBus: '05:30', lastBus: '22:30'),
      BusRoute(number: '40', direction: 'Вокзал - Берёзовка', frequencyMinutes: 15, firstBus: '06:00', lastBus: '22:00'),
    ],
  ),

  // ========== ВОРОНЕЖ ==========
  BusStop(
    id: 'vor_extra_001',
    name: 'Воронеж-1',
    city: 'Воронеж',
    district: 'Центральный',
    lat: 51.6700,
    lng: 39.1842,
    routes: [
      BusRoute(number: 'АВ', direction: 'Вокзал - Левобережный', frequencyMinutes: 8, firstBus: '05:30', lastBus: '00:30'),
      BusRoute(number: '17', direction: 'Вокзал - Юго-Западный', frequencyMinutes: 10, firstBus: '05:30', lastBus: '23:00'),
      BusRoute(number: '88', direction: 'Вокзал - СХИ', frequencyMinutes: 12, firstBus: '06:00', lastBus: '22:00'),
    ],
  ),

  // ========== ХАБАРОВСК ==========
  BusStop(
    id: 'khv_extra_001',
    name: 'Хабаровск жд вокзал',
    city: 'Хабаровск',
    district: 'Центральный',
    lat: 48.4833,
    lng: 135.0833,
    routes: [
      BusRoute(number: '1', direction: 'Вокзал - Тополевка', frequencyMinutes: 10, firstBus: '05:30', lastBus: '23:00'),
      BusRoute(number: '6', direction: 'Вокзал - Аэропорт', frequencyMinutes: 12, firstBus: '05:00', lastBus: '00:30'),
      BusRoute(number: '33', direction: 'Вокзал - Северный', frequencyMinutes: 15, firstBus: '06:00', lastBus: '22:00'),
    ],
  ),

  // ========== БАРНАУЛ ==========
  BusStop(
    id: 'barn_extra_001',
    name: 'Барнаул автовокзал',
    city: 'Барнаул',
    district: 'Центральный',
    lat: 53.3533,
    lng: 83.7667,
    routes: [
      BusRoute(number: '1', direction: 'Автовокзал - Левобережный', frequencyMinutes: 10, firstBus: '05:30', lastBus: '23:00'),
      BusRoute(number: '22', direction: 'Автовокзал - Гоньба', frequencyMinutes: 15, firstBus: '06:00', lastBus: '22:00'),
    ],
  ),

  // ========== ТОМСК ==========
  BusStop(
    id: 'tomsk_extra_001',
    name: 'Томск автовокзал',
    city: 'Томск',
    district: 'Центральный',
    lat: 56.4667,
    lng: 84.9500,
    routes: [
      BusRoute(number: '1', direction: 'Автовокзал - Каштак', frequencyMinutes: 10, firstBus: '05:30', lastBus: '23:00'),
      BusRoute(number: '12', direction: 'Автовокзал - Теремок', frequencyMinutes: 12, firstBus: '06:00', lastBus: '22:00'),
      BusRoute(number: '25', direction: 'Автовокзал - На химмаш', frequencyMinutes: 15, firstBus: '06:00', lastBus: '21:30'),
    ],
  ),

  // ========== ОМСК ==========
  BusStop(
    id: 'omsk_extra_001',
    name: 'Омск жд вокзал',
    city: 'Омск',
    district: 'Центральный',
    lat: 54.9833,
    lng: 73.3667,
    routes: [
      BusRoute(number: '1', direction: 'Вокзал - Аэропорт', frequencyMinutes: 10, firstBus: '05:30', lastBus: '23:00'),
      BusRoute(number: '11', direction: 'Вокзал - Сырково', frequencyMinutes: 12, firstBus: '05:30', lastBus: '22:30'),
      BusRoute(number: '57', direction: 'Вокзал - Ключи', frequencyMinutes: 15, firstBus: '06:00', lastBus: '22:00'),
    ],
  ),

  // ========== КАЛИНИНГРАД ==========
  BusStop(
    id: 'kgd_extra_001',
    name: 'Калининград жд вокзал',
    city: 'Калининград',
    district: 'Центральный',
    lat: 54.7000,
    lng: 20.5000,
    routes: [
      BusRoute(number: '29', direction: 'Вокзал - Балтийский', frequencyMinutes: 10, firstBus: '05:30', lastBus: '23:00'),
      BusRoute(number: '33', direction: 'Вокзал - Южный', frequencyMinutes: 12, firstBus: '05:30', lastBus: '22:30'),
      BusRoute(number: '96', direction: 'Вокзал - Черняховск', frequencyMinutes: 20, firstBus: '06:00', lastBus: '21:00'),
    ],
  ),

  // ========== ПЕРМЬ ==========
  BusStop(
    id: 'perm_extra_001',
    name: 'Пермь жд вокзал',
    city: 'Пермь',
    district: 'Центральный',
    lat: 58.0100,
    lng: 56.2500,
    routes: [
      BusRoute(number: '3', direction: 'Вокзал - Садовнический', frequencyMinutes: 10, firstBus: '05:30', lastBus: '23:00'),
      BusRoute(number: '16', direction: 'Вокзал - Сырье', frequencyMinutes: 12, firstBus: '05:30', lastBus: '22:30'),
      BusRoute(number: '29', direction: 'Вокзал - Мостовка', frequencyMinutes: 15, firstBus: '06:00', lastBus: '22:00'),
    ],
  ),

  // ========== САРАТОВ ==========
  BusStop(
    id: 'srt_extra_001',
    name: 'Саратов жд вокзал',
    city: 'Саратов',
    district: 'Центральный',
    lat: 51.5333,
    lng: 46.0167,
    routes: [
      BusRoute(number: '1', direction: 'Вокзал - Сенная', frequencyMinutes: 10, firstBus: '05:30', lastBus: '23:00'),
      BusRoute(number: '13', direction: 'Вокзал - Университет', frequencyMinutes: 12, firstBus: '05:30', lastBus: '22:30'),
      BusRoute(number: '42', direction: 'Вокзал - Энтузиаст', frequencyMinutes: 15, firstBus: '06:00', lastBus: '22:00'),
    ],
  ),

  // ========== СУРГУТ ==========
  BusStop(
    id: 'sgt_extra_001',
    name: 'Сургут автовокзал',
    city: 'Сургут',
    district: 'Центральный',
    lat: 61.2500,
    lng: 73.4000,
    routes: [
      BusRoute(number: '1', direction: 'Автовокзал - Комсомольский', frequencyMinutes: 10, firstBus: '05:30', lastBus: '23:00'),
      BusRoute(number: '12', direction: 'Автовокзал - Бадёжный', frequencyMinutes: 12, firstBus: '06:00', lastBus: '22:00'),
    ],
  ),

  // ========== ТВЕРЬ ==========
  BusStop(
    id: 'tvr_extra_001',
    name: 'Тверь автовокзал',
    city: 'Тверь',
    district: 'Центральный',
    lat: 56.8583,
    lng: 35.9167,
    routes: [
      BusRoute(number: 'АВ', direction: 'Автовокзал - Пролетарка', frequencyMinutes: 10, firstBus: '05:30', lastBus: '23:00'),
      BusRoute(number: '7', direction: 'Автовокзал - Домodedovo', frequencyMinutes: 12, firstBus: '06:00', lastBus: '22:00'),
    ],
  ),

  // ========== ЯРОСЛАВЛЬ ==========
  BusStop(
    id: 'yar_extra_001',
    name: 'Ярославль автовокзал',
    city: 'Ярославль',
    district: 'Центральный',
    lat: 57.6500,
    lng: 39.8500,
    routes: [
      BusRoute(number: 'АВ', direction: 'Автовокзал - Заречье', frequencyMinutes: 10, firstBus: '05:30', lastBus: '23:00'),
      BusRoute(number: '14', direction: 'Автовокзал - Красный Перекоп', frequencyMinutes: 12, firstBus: '05:30', lastBus: '22:30'),
      BusRoute(number: '35', direction: 'Автовокзал - Селиваново', frequencyMinutes: 15, firstBus: '06:00', lastBus: '22:00'),
    ],
  ),

  // ========== ОРЁЛ ==========
  BusStop(
    id: 'orl_extra_001',
    name: 'Орёл автовокзал',
    city: 'Орёл',
    district: 'Центральный',
    lat: 52.9667,
    lng: 36.0667,
    routes: [
      BusRoute(number: '1', direction: 'Автовокзал - Заводской', frequencyMinutes: 10, firstBus: '05:30', lastBus: '23:00'),
      BusRoute(number: '2', direction: 'Автовокзал - Нефтезавод', frequencyMinutes: 12, firstBus: '06:00', lastBus: '22:00'),
    ],
  ),

  // ========== КУРСК ==========
  BusStop(
    id: 'krs_001',
    name: 'Курск автовокзал',
    city: 'Курск',
    district: 'Центральный',
    lat: 51.7333,
    lng: 36.1833,
    routes: [
      BusRoute(number: '1', direction: 'Автовокзал - Дуговое', frequencyMinutes: 10, firstBus: '05:30', lastBus: '23:00'),
      BusRoute(number: '5', direction: 'Автовокзал - Универсам', frequencyMinutes: 12, firstBus: '06:00', lastBus: '22:00'),
    ],
  ),

  // ========== БЕЛГОРОД ==========
  BusStop(
    id: 'blg_extra_001',
    name: 'Белгород автовокзал',
    city: 'Белгород',
    district: 'Центральный',
    lat: 50.6000,
    lng: 36.5833,
    routes: [
      BusRoute(number: '1', direction: 'Автовокзал - Майский', frequencyMinutes: 10, firstBus: '05:30', lastBus: '23:00'),
      BusRoute(number: '10', direction: 'Автовокзал - Новый посёлок', frequencyMinutes: 12, firstBus: '06:00', lastBus: '22:00'),
    ],
  ),

  // ========== СТАВРОПОЛЬ ==========
  BusStop(
    id: 'stv_extra_001',
    name: 'Ставрополь автовокзал',
    city: 'Ставрополь',
    district: 'Центральный',
    lat: 45.0433,
    lng: 41.9733,
    routes: [
      BusRoute(number: '1', direction: 'Автовокзал - Курсавка', frequencyMinutes: 12, firstBus: '05:30', lastBus: '22:30'),
      BusRoute(number: '10', direction: 'Автовокзал - Левокумское', frequencyMinutes: 15, firstBus: '06:00', lastBus: '22:00'),
    ],
  ),

  // ========== ПЯТИГОРСК ==========
  BusStop(
    id: 'ptg_extra_001',
    name: 'Пятигорск автовокзал',
    city: 'Пятигорск',
    district: 'Центральный',
    lat: 44.0417,
    lng: 43.0583,
    routes: [
      BusRoute(number: 'АВ', direction: 'Автовокзал - Кисловодск', frequencyMinutes: 15, firstBus: '05:00', lastBus: '23:00'),
      BusRoute(number: '1', direction: 'Автоворот - Институт культуры', frequencyMinutes: 8, firstBus: '06:00', lastBus: '22:00'),
    ],
  ),

  // ========== КЕМЕРОВО ==========
  BusStop(
    id: 'kem_extra_001',
    name: 'Кемерово жд вокзал',
    city: 'Кемерово',
    district: 'Центральный',
    lat: 55.3333,
    lng: 86.0833,
    routes: [
      BusRoute(number: '1', direction: 'Вокзал - Ленинск-Кузнецкий', frequencyMinutes: 12, firstBus: '05:30', lastBus: '22:30'),
      BusRoute(number: '4', direction: 'Вокзал - Заводская', frequencyMinutes: 10, firstBus: '05:30', lastBus: '23:00'),
      BusRoute(number: '32', direction: 'Вокзал - Краснинский', frequencyMinutes: 15, firstBus: '06:00', lastBus: '22:00'),
    ],
  ),

  // ========== НОВОКУЗНЕЦК ==========
  BusStop(
    id: 'nvkz_extra_001',
    name: 'Новокузнецк жд вокзал',
    city: 'Новокузнецк',
    district: 'Центральный',
    lat: 53.7500,
    lng: 87.1167,
    routes: [
      BusRoute(number: '1', direction: 'Вокзал - ТОАЗ', frequencyMinutes: 10, firstBus: '05:30', lastBus: '23:00'),
      BusRoute(number: '5', direction: 'Вокзал - КМЗ', frequencyMinutes: 12, firstBus: '05:30', lastBus: '22:30'),
    ],
  ),

  // ========== ИЖЕВСК ==========
  BusStop(
    id: 'izh_extra_001',
    name: 'Ижевск жд вокзал',
    city: 'Ижевск',
    district: 'Центральный',
    lat: 56.8500,
    lng: 53.2167,
    routes: [
      BusRoute(number: '1', direction: 'Вокзал - Северный', frequencyMinutes: 10, firstBus: '05:30', lastBus: '23:00'),
      BusRoute(number: '4', direction: 'Вокзал - Омутнинск', frequencyMinutes: 15, firstBus: '06:00', lastBus: '22:00'),
    ],
  ),

  // ========== СЫКТЫВКАР ==========
  BusStop(
    id: 'syk_extra_001',
    name: 'Сыктывкар автовокзал',
    city: 'Сыктывкар',
    district: 'Центральный',
    lat: 61.6667,
    lng: 50.8167,
    routes: [
      BusRoute(number: '1', direction: 'Автовокзал - Путейский', frequencyMinutes: 12, firstBus: '05:30', lastBus: '22:30'),
      BusRoute(number: '10', direction: 'Автовокзал - Вычегда', frequencyMinutes: 15, firstBus: '06:00', lastBus: '22:00'),
    ],
  ),

  // ========== МУРМАНСК ==========
  BusStop(
    id: 'mmk_extra_001',
    name: 'Мурманск жд вокзал',
    city: 'Мурманск',
    district: 'Центральный',
    lat: 68.9667,
    lng: 33.0833,
    routes: [
      BusRoute(number: 'АВ', direction: 'Вокзал - Кольский', frequencyMinutes: 10, firstBus: '05:30', lastBus: '23:00'),
      BusRoute(number: '16', direction: 'Вокзал - Пялица', frequencyMinutes: 15, firstBus: '06:00', lastBus: '22:00'),
    ],
  ),

  // ========== АРХАНГЕЛЬСК ==========
  BusStop(
    id: 'arh_extra_001',
    name: 'Архангельск жд вокзал',
    city: 'Архангельск',
    district: 'Центральный',
    lat: 64.5333,
    lng: 40.5333,
    routes: [
      BusRoute(number: '1', direction: 'Вокзал - Ленинградский', frequencyMinutes: 12, firstBus: '05:30', lastBus: '22:30'),
      BusRoute(number: '7', direction: 'Вокзал - Гаражный', frequencyMinutes: 15, firstBus: '06:00', lastBus: '22:00'),
    ],
  ),

  // ========== КЕМЕРОВСКАЯ ОБЛАСТЬ ==========
  BusStop(
    id: 'kem_obl_001',
    name: 'Белово автовокзал',
    city: 'Кемеровская область',
    district: 'Белово',
    lat: 54.4167,
    lng: 86.3000,
    routes: [
      BusRoute(number: '1', direction: 'Белово - Кемерово', frequencyMinutes: 15, firstBus: '05:30', lastBus: '22:00'),
      BusRoute(number: '10', direction: 'Белово - Грамотеино', frequencyMinutes: 20, firstBus: '06:00', lastBus: '21:00'),
    ],
  ),
  BusStop(
    id: 'kem_obl_002',
    name: 'Прокопьевск жд вокзал',
    city: 'Кемеровская область',
    district: 'Прокопьевск',
    lat: 53.8833,
    lng: 86.7500,
    routes: [
      BusRoute(number: '1', direction: 'Прокопьевск - Кемерово', frequencyMinutes: 15, firstBus: '05:30', lastBus: '22:00'),
      BusRoute(number: '4', direction: 'Прокопьевск - Бачатский', frequencyMinutes: 20, firstBus: '06:00', lastBus: '21:00'),
    ],
  ),
];
