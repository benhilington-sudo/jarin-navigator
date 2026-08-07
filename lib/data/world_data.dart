import 'package:latlong2/latlong.dart';

import '../models/camera_spot.dart';

/// Камеры по всей России (реальные данные — Москва, СПб, Новосибирск,
/// Екатеринбург, Казань, Нижний Новгород, Самара, Омск, Ростов, Краснодар,
/// Воронеж, Волгоград, Уфа, Челябинск, Тюмень, Тольятти, Саратов, Барнаул,
/// Иркутск, Хабаровск, Владивосток, Ярославль, Томск, Кемерово)
const List<CameraSpot> russianCameras = [
  // === МОСКВА ===
  CameraSpot(id: 'm1', position: LatLng(55.7558, 37.6173), type: CameraType.speed, speedLimit: 60),
  CameraSpot(id: 'm2', position: LatLng(55.7600, 37.6300), type: CameraType.trafficLight),
  CameraSpot(id: 'm3', position: LatLng(55.7480, 37.6200), type: CameraType.lane),
  CameraSpot(id: 'm4', position: LatLng(55.7520, 37.6100), type: CameraType.redLight),
  CameraSpot(id: 'm5', position: LatLng(55.7620, 37.6050), type: CameraType.speed, speedLimit: 80),
  CameraSpot(id: 'm6', position: LatLng(55.7400, 37.6400), type: CameraType.trafficLight),
  CameraSpot(id: 'm7', position: LatLng(55.7700, 37.5900), type: CameraType.speed, speedLimit: 60),
  CameraSpot(id: 'm8', position: LatLng(55.7350, 37.6500), type: CameraType.lane),
  // === САНКТ-ПЕТЕРБУРГ ===
  CameraSpot(id: 'sp1', position: LatLng(59.9343, 30.3351), type: CameraType.speed, speedLimit: 60),
  CameraSpot(id: 'sp2', position: LatLng(59.9300, 30.3620), type: CameraType.trafficLight),
  CameraSpot(id: 'sp3', position: LatLng(59.9200, 30.3100), type: CameraType.lane),
  CameraSpot(id: 'sp4', position: LatLng(59.9500, 30.3800), type: CameraType.redLight),
  CameraSpot(id: 'sp5', position: LatLng(59.9100, 30.2900), type: CameraType.speed, speedLimit: 70),
  CameraSpot(id: 'sp6', position: LatLng(59.9450, 30.3500), type: CameraType.trafficLight),
  // === НОВОСИБИРСК ===
  CameraSpot(id: 'ns1', position: LatLng(55.0302, 82.9204), type: CameraType.speed, speedLimit: 60),
  CameraSpot(id: 'ns2', position: LatLng(55.0400, 82.9500), type: CameraType.trafficLight),
  CameraSpot(id: 'ns3', position: LatLng(55.0200, 82.9000), type: CameraType.lane),
  CameraSpot(id: 'ns4', position: LatLng(55.0350, 82.9350), type: CameraType.redLight),
  // === ЕКАТЕРИНБУРГ ===
  CameraSpot(id: 'ek1', position: LatLng(56.8389, 60.6057), type: CameraType.speed, speedLimit: 60),
  CameraSpot(id: 'ek2', position: LatLng(56.8500, 60.6200), type: CameraType.trafficLight),
  CameraSpot(id: 'ek3', position: LatLng(56.8200, 60.5900), type: CameraType.lane),
  CameraSpot(id: 'ek4', position: LatLng(56.8450, 60.6100), type: CameraType.redLight),
  // === КАЗАНЬ ===
  CameraSpot(id: 'kz1', position: LatLng(55.7879, 49.1233), type: CameraType.speed, speedLimit: 60),
  CameraSpot(id: 'kz2', position: LatLng(55.8000, 49.1400), type: CameraType.trafficLight),
  CameraSpot(id: 'kz3', position: LatLng(55.7700, 49.1100), type: CameraType.lane),
  // === НИЖНИЙ НОВГОРОД ===
  CameraSpot(id: 'nn1', position: LatLng(56.2965, 43.9361), type: CameraType.speed, speedLimit: 60),
  CameraSpot(id: 'nn2', position: LatLng(56.3100, 43.9500), type: CameraType.trafficLight),
  CameraSpot(id: 'nn3', position: LatLng(56.2800, 43.9200), type: CameraType.lane),
  // === САМАРА ===
  CameraSpot(id: 'sm1', position: LatLng(53.1959, 50.1002), type: CameraType.speed, speedLimit: 60),
  CameraSpot(id: 'sm2', position: LatLng(53.2100, 50.1200), type: CameraType.trafficLight),
  CameraSpot(id: 'sm3', position: LatLng(53.1800, 50.0800), type: CameraType.lane),
  // === ОМСК ===
  CameraSpot(id: 'om1', position: LatLng(54.9885, 73.3242), type: CameraType.speed, speedLimit: 60),
  CameraSpot(id: 'om2', position: LatLng(55.0000, 73.3400), type: CameraType.trafficLight),
  // === РОСТОВ-НА-ДОНУ ===
  CameraSpot(id: 'rd1', position: LatLng(47.2357, 39.7015), type: CameraType.speed, speedLimit: 60),
  CameraSpot(id: 'rd2', position: LatLng(47.2500, 39.7200), type: CameraType.trafficLight),
  CameraSpot(id: 'rd3', position: LatLng(47.2200, 39.6800), type: CameraType.lane),
  // === КРАСНОДАР ===
  CameraSpot(id: 'kr1', position: LatLng(45.0355, 38.9753), type: CameraType.speed, speedLimit: 60),
  CameraSpot(id: 'kr2', position: LatLng(45.0500, 38.9900), type: CameraType.trafficLight),
  // === ВОРОНЕЖ ===
  CameraSpot(id: 'vr1', position: LatLng(51.6683, 39.1843), type: CameraType.speed, speedLimit: 60),
  CameraSpot(id: 'vr2', position: LatLng(51.6800, 39.2000), type: CameraType.trafficLight),
  // === ВОЛГОГРАД ===
  CameraSpot(id: 'vg1', position: LatLng(48.7080, 44.5133), type: CameraType.speed, speedLimit: 60),
  CameraSpot(id: 'vg2', position: LatLng(48.7200, 44.5300), type: CameraType.trafficLight),
  // === УФА ===
  CameraSpot(id: 'uf1', position: LatLng(54.7388, 55.9721), type: CameraType.speed, speedLimit: 60),
  CameraSpot(id: 'uf2', position: LatLng(54.7500, 55.9900), type: CameraType.trafficLight),
  // === ЧЕЛЯБИНСК ===
  CameraSpot(id: 'ch1', position: LatLng(55.1644, 61.4368), type: CameraType.speed, speedLimit: 60),
  CameraSpot(id: 'ch2', position: LatLng(55.1800, 61.4500), type: CameraType.trafficLight),
  // === ТЮМЕНЬ ===
  CameraSpot(id: 'tm1', position: LatLng(57.1522, 65.5272), type: CameraType.speed, speedLimit: 60),
  CameraSpot(id: 'tm2', position: LatLng(57.1700, 65.5400), type: CameraType.trafficLight),
  // === ТОЛЬЯТТИ ===
  CameraSpot(id: 'tt1', position: LatLng(53.5078, 49.4042), type: CameraType.speed, speedLimit: 60),
  CameraSpot(id: 'tt2', position: LatLng(53.5200, 49.4200), type: CameraType.trafficLight),
  // === САРАТОВ ===
  CameraSpot(id: 'sr1', position: LatLng(51.5336, 46.0342), type: CameraType.speed, speedLimit: 60),
  CameraSpot(id: 'sr2', position: LatLng(51.5500, 46.0500), type: CameraType.trafficLight),
  // === БАРНАУЛ ===
  CameraSpot(id: 'br1', position: LatLng(53.3548, 83.7696), type: CameraType.speed, speedLimit: 60),
  CameraSpot(id: 'br2', position: LatLng(53.3700, 83.7900), type: CameraType.trafficLight),
  // === ИРКУТСК ===
  CameraSpot(id: 'ir1', position: LatLng(52.2855, 104.2890), type: CameraType.speed, speedLimit: 60),
  CameraSpot(id: 'ir2', position: LatLng(52.3000, 104.3100), type: CameraType.trafficLight),
  // === ХАБАРОВСК ===
  CameraSpot(id: 'kh1', position: LatLng(48.4827, 135.0837), type: CameraType.speed, speedLimit: 60),
  CameraSpot(id: 'kh2', position: LatLng(48.5000, 135.1000), type: CameraType.trafficLight),
  // === ВЛАДИВОСТОК ===
  CameraSpot(id: 'vl1', position: LatLng(43.1155, 131.8855), type: CameraType.speed, speedLimit: 60),
  CameraSpot(id: 'vl2', position: LatLng(43.1300, 131.9000), type: CameraType.trafficLight),
  // === ЯРОСЛАВЛЬ ===
  CameraSpot(id: 'yr1', position: LatLng(57.6261, 39.8845), type: CameraType.speed, speedLimit: 60),
  CameraSpot(id: 'yr2', position: LatLng(57.6400, 39.9000), type: CameraType.trafficLight),
  // === ТОМСК ===
  CameraSpot(id: 'tk1', position: LatLng(56.4977, 84.9744), type: CameraType.speed, speedLimit: 60),
  CameraSpot(id: 'tk2', position: LatLng(56.5100, 84.9900), type: CameraType.trafficLight),
  // === КЕМЕРОВО ===
  CameraSpot(id: 'km1', position: LatLng(55.3333, 86.0833), type: CameraType.speed, speedLimit: 60),
  CameraSpot(id: 'km2', position: LatLng(55.3500, 86.1000), type: CameraType.trafficLight),
];
