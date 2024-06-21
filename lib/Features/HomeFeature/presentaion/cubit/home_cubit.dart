import 'dart:convert';
import 'dart:developer';

import 'package:adhan/adhan.dart';
import 'package:azzan/Features/HomeFeature/presentaion/prayer_times_servies.dart';
import 'package:azzan/core/Network/di.dart';
import 'package:azzan/core/Network/sharred_pref.dart';
import 'package:azzan/core/Utils/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:jhijri/_src/_jHijri.dart';
import 'package:jhijri/jHijri.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final now = DateTime.now();

  Preferences pref = Preferences();

  List<String> prayerForSunRieseAndMidDayAndSunset = [
    'الشروق',
    'منتصف اليوم',
    'الغروب',
  ];

  ///**************************************************** */
  DateTime? sunRise;
  DateTime? sunSet;
  DateTime? midDay;
  List<String> listOfSunRiseAndSunSetDateTimes = [];
  void calSunRiseAndMidDayAndSunSet() {
    listOfSunRiseAndSunSetDateTimes = [];
    sunRise = timesForEachPrayerInEgypt[0];
    sunSet = timesForEachPrayerInEgypt[4];
    midDay = calculateMidday(sunRise!, sunSet!);
    listOfSunRiseAndSunSetDateTimes.add(listOfPrayerTimes[1]);
    listOfSunRiseAndSunSetDateTimes.add('${midDay!.hour}:${midDay!.minute}');
    listOfSunRiseAndSunSetDateTimes.add(listOfPrayerTimes[4]);
  }

  DateTime calculateMidday(DateTime sunrise, DateTime sunset) {
    Duration difference = sunset.difference(sunrise);
    Duration halfDifference = difference ~/ 2;
    DateTime midday = sunrise.add(halfDifference);
    return midday;
  }
//*********************************************************************** */

  List<String> prayerNames = [
    'الفجر',
    'الشروق',
    'الظهر',
    'العصر',
    'المغرب',
    'العشاء'
  ];
  List<bool> prayerSatatus = [
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  List<String> prayerIconsImages = [
    'assets/images/Shalat-Shubuh.png',
    'assets/images/Shalat-Dhuha.png',
    'assets/images/Shalat-Zhuhur.png',
    'assets/images/Shalat-Ashar.png',
    'assets/images/Shalat-Maghrib.png',
    'assets/images/Shalat-Isya.png',
  ];

  Map<String, bool> switchButtonForEachPrayerMap = {
    'Fajr': true,
    'SunRise ': true,
    'Dhuhr ': true,
    'Asr ': true,
    'Maghrib ': true,
    'Isha ': true,
  };

  //!*********** ******** HERE We Want to make Sharred Pref for all prayer Values   //!

// ! this list for swtich the notification for paryer times
  List<bool> switchButtonForEachPrayer = [
    true, // 0 for fajr
    true, // 1  for the sunrise
    true, // 2 for the duhar
    true, // 3 for the asr
    true, // 4 for the magreb
    true, //5 for isha
  ];
  // TODO implement Sharred Pref
  Future<void> changeTheSwitchButtonForEachPrayer({
    required int index,
  }) async {
    emit(HomeSwitchToggleLoading());
    switchButtonForEachPrayer[index] = !switchButtonForEachPrayer[index];
    // await saveBooleanList();

    emit(HomeSwitchToggleSuccesss());
  }

  Future<void> loadBooleanListCubit() async {
    emit(HomeGetSharredLoading());
    switchButtonForEachPrayer =
        await getIt.get<Preferences>().loadBooleanList('key');
    log('${switchButtonForEachPrayer[1]}');
    emit(HomeGetSharredSucess());
  }

  Future<void> saveBooleanListCubit() async {
    emit(HomeSharrePrefChange());
    getIt.get<Preferences>().saveBooleanList(switchButtonForEachPrayer, 'key');

    emit(HomeSharredPrefSuccess());
  }

//******************************************************************************************** */
  PryerTimeService pryerTimeService = getIt.get<PryerTimeService>();
  late PrayerTimes prayerTimes;
  Future<void> getPrayerTimeSuccessFromCubit() async {
    emit(HomeGetPrayerTimeLoading());

    prayerTimes = await pryerTimeService.calculatePrayerTime();

    emit(HomeGetPrayerTimeSuccess());
  }

  void seduleNotifcationUsingWorkManager() async {
    log('before the line of workmanager .........................................');
    final pryaerTimesList = {
      'Fajr': prayerTimes.fajr,
      'SunRise': prayerTimes.sunrise,
      'Dhuhr': prayerTimes.dhuhr,
      'Asr': prayerTimes.asr,
      'Maghrib': prayerTimes.maghrib,
      'Isha': prayerTimes.isha,
    };

    pryaerTimesList.forEach((prayerName, time) {
      //TODO here we cheeck for the array values if there was true or false   hitttttttttt
      if (prayerName == 'Fajr' && switchButtonForEachPrayer[0] == true) {
        registerToWorkManager(prayerName: prayerName, time: time);
      }
      if (prayerName == 'SunRise' && switchButtonForEachPrayer[1] == true) {
        registerToWorkManager(prayerName: prayerName, time: time);
      }
      if (prayerName == 'Dhuhr' && switchButtonForEachPrayer[2] == true) {
        registerToWorkManager(prayerName: prayerName, time: time);
      }
      if (prayerName == 'Asr' && switchButtonForEachPrayer[3] == true) {
        registerToWorkManager(prayerName: prayerName, time: time);
      }
      if (prayerName == 'Maghrib' && switchButtonForEachPrayer[4] == true) {
        registerToWorkManager(prayerName: prayerName, time: time);
      }
      if (prayerName == 'Isha' && switchButtonForEachPrayer[5] == true) {
        registerToWorkManager(prayerName: prayerName, time: time);
      }
    });

    log('after the line of workmanager ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;');
  }

  void registerToWorkManager(
      {required String prayerName, required DateTime time}) async {
    await Workmanager()
        .registerOneOffTask(prayerName, "schedulePrayerNotifications",
            inputData: {
              'prayerName': prayerName,
              'time': time.toIso8601String(),
            },
            initialDelay: Duration(seconds: 10))
        .then((value) {
      print('Task $prayerName registered with time $time');
    });
  }

  //****************************** ent the foucntion Secdule WorkManager */

  int? remainIngTimeInHours;
  int? remainTimeInMinutes;
  Duration? timeUntilNextPryaer;
  Future<Duration> calDifferenc(DateTime dataTimeLocal) async {
    emit(HomeCalDiffLoading());
    timeUntilNextPryaer = dataTimeLocal.difference(now);
    remainIngTimeInHours = timeUntilNextPryaer!.inHours;
    remainTimeInMinutes = timeUntilNextPryaer!.inMinutes;
    emit(HomeCalDiffSucces());
    return timeUntilNextPryaer!;
  }

//************************************************************************ *******************/
//****** problem here in subtract  */
  DateTime calTimeinEgyptByDateTime(DateTime prayertime) {
    emit(HomeAcutalRealTimeLoading());
    prayertime = prayertime.toLocal();
    emit(HomeAcutalRealTimeSuccess());
    return prayertime;
  }

  List<DateTime> timesForEachPrayerInEgypt = [];
  prayerTimeInEgypt() {
    timesForEachPrayerInEgypt = [];
    timesForEachPrayerInEgypt.add(calTimeinEgyptByDateTime(prayerTimes.fajr));
    timesForEachPrayerInEgypt
        .add(calTimeinEgyptByDateTime(prayerTimes.sunrise));
    timesForEachPrayerInEgypt.add(calTimeinEgyptByDateTime(prayerTimes.dhuhr));
    timesForEachPrayerInEgypt.add(calTimeinEgyptByDateTime(prayerTimes.asr));
    timesForEachPrayerInEgypt
        .add(calTimeinEgyptByDateTime(prayerTimes.maghrib));
    timesForEachPrayerInEgypt.add(calTimeinEgyptByDateTime(prayerTimes.isha));
  }

  int? upcomingPrayerIndex;
  DateTime? upcomingPrayerTime;
  void findUpcomingPrayer() {
    emit(HomeFindUpCommingPryaerLoading());
    upcomingPrayerIndex = 0;
    for (int i = 0; i < timesForEachPrayerInEgypt.length; i++) {
      if (timesForEachPrayerInEgypt[i].isAfter(now)) {
        upcomingPrayerIndex = i;
        upcomingPrayerTime = timesForEachPrayerInEgypt[i];
        break;
      }
    }
    emit(HomeFindUpCommingPryaerSuccess());
  }

  int? currentPrayerIndex;
  DateTime? curretnPrayerTime;

  String getCurrentPrayerInArabic() {
    //0 fajar
    //1 sunrise
    //2 duhar
    //3 asar
    //4 mahrab
    //5 ishaa
    // fajar
    if (now.isBefore(timesForEachPrayerInEgypt[0])) {
      currentPrayerIndex = 5;
      return prayerNames[5];
    } else if (now.isBefore(timesForEachPrayerInEgypt[1])) {
      currentPrayerIndex = 0;
      return prayerNames[0];
    } else if (now.isBefore(timesForEachPrayerInEgypt[2])) {
      currentPrayerIndex = 1;
      return prayerNames[1];
    } else if (now.isBefore(timesForEachPrayerInEgypt[3])) {
      currentPrayerIndex = 2;
      return prayerNames[2];
    } else if (now.isBefore(timesForEachPrayerInEgypt[4])) {
      currentPrayerIndex = 3;
      return prayerNames[3];
    } else if (now.isBefore(timesForEachPrayerInEgypt[5])) {
      currentPrayerIndex = 4;
      return prayerNames[4];
    } else {
      currentPrayerIndex = 5;
      return prayerNames[5];
    }
  }

//**************************************************************************** */
  List<String> listOfPrayerTimes = [];
  String callistOfPrayerTimes(Prayer prayer) {
    emit(HomeCalTimeLoading());
    DateTime? nextTIme = prayerTimes.timeForPrayer(prayer);

    String hours = nextTIme!.hour.toString();

    String minute = nextTIme.minute.toString();
    if (int.parse(minute) < 10) {
      minute = '0${minute}';
    }
    emit(HomeCalTimeSuccess());
    return '${hours}:${minute}';
  }

  fillListWithThePrayerTimes() {
    listOfPrayerTimes = [];
    listOfPrayerTimes.add(callistOfPrayerTimes(Prayer.fajr));
    listOfPrayerTimes.add(callistOfPrayerTimes(Prayer.sunrise));
    listOfPrayerTimes.add(callistOfPrayerTimes(Prayer.dhuhr));
    listOfPrayerTimes.add(callistOfPrayerTimes(Prayer.asr));
    listOfPrayerTimes.add(callistOfPrayerTimes(Prayer.maghrib));
    listOfPrayerTimes.add(callistOfPrayerTimes(Prayer.isha));
  }

//**************************************************************************** */

  //***               الشهور الميلادى    ********************* */
  int getCurrentDayOfMonth() {
    return now.day;
  }

  String getMonthName() {
    var formatter = DateFormat('MMMM', AppValues.langCodeBase);
    String monthName = formatter.format(now);
    return monthName;
  }

  String getDayName() {
    var formatter = DateFormat('EEEE', AppValues.langCodeBase);
    String dayName = formatter.format(now);
    return dayName;
  }

  int getYearName() {
    int yearNmae = DateTime.now().year;
    return yearNmae;
  }

  //*    to get the month with الهجرى الشهور الهحرى      ************************
  String getCurrentHijriMonthName() {
    final hijriDate = JHijri.now();
    final monthName = hijriDate.monthName;
    return monthName;
  }

  int getCurrentHijriMonthday() {
    final hijriDate = JHijri.now();
    final monthday = hijriDate.day;
    return monthday;
  }

  int getCurrentHijriYearName() {
    final hijriDate = JHijri.now();
    final monthday = hijriDate.year;
    return monthday;
  }

  ///******************************************************************************* */
  //*****  get the time zone  */
  Future<String> getTimeZoneFromCoordinates(
      double latitude, double longitude) async {
    final response = await http.get(Uri.parse(
        'https://api.timezonedb.com/v2.1/get-time-zone?key=UDTA6COJC039&format=json&by=position&lat=$latitude&lng=$longitude'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['zoneName'];
    } else {
      throw Exception('Failed to load time zone data');
    }
  }

  //*** get the current prayer  and next prayer ****************** */

  final Map<Prayer, String> prayerNamesInArabic = {
    Prayer.fajr: 'الفجر',
    Prayer.sunrise: 'الشروق',
    Prayer.dhuhr: 'الظهر',
    Prayer.asr: 'العصر',
    Prayer.maghrib: 'المغرب',
    Prayer.isha: 'العشاء'
  };

  // String getCurrentPrayerInArabic() {
  //   final DateTime now = DateTime.now();
  //   Prayer currentPrayer = prayerTimes.currentPrayer();

  //   // Check if the current time is after the time for the next prayer
  //   if (prayerTimes.timeForPrayer(currentPrayer)!.isBefore(now)) {
  //     currentPrayer = prayerTimes.currentPrayer();
  //   }

  //   return prayerNamesInArabic[currentPrayer]!;
  // }

  String getNextPrayerInArabic() {
    final DateTime now = DateTime.now();
    Prayer currentPrayer = prayerTimes.currentPrayer();

    // Check if the current time is after the time for the next prayer
    if (prayerTimes.timeForPrayer(currentPrayer)!.isBefore(now)) {
      currentPrayer = prayerTimes.nextPrayer();
    }

    return prayerNamesInArabic[currentPrayer]!;
  }

  //********************************************************************************** */
}
