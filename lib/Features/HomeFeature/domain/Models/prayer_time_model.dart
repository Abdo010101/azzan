import 'package:adhan/adhan.dart';

class PrayerTimeModels {
  DateTime? fajr;
  DateTime? sunrise;
  DateTime? dhuhr;
  DateTime? asr;
  DateTime? maghrib;
  DateTime? isha;

  PrayerTimeModels({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  factory PrayerTimeModels.fromPrayerTimes(PrayerTimes prayerTimes) {
    return PrayerTimeModels(
      fajr: prayerTimes.fajr,
      sunrise: prayerTimes.sunrise,
      dhuhr: prayerTimes.dhuhr,
      asr: prayerTimes.asr,
      maghrib: prayerTimes.maghrib,
      isha: prayerTimes.isha,
    );
  }
}
