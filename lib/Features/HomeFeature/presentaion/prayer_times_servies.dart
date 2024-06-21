import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'package:azzan/core/Utils/constants.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:adhan/adhan.dart';
import 'package:azzan/Features/HomeFeature/domain/Models/prayer_time_model.dart';
import 'package:azzan/core/Service/location_service.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'dart:core' as core;
import 'package:geocoding/geocoding.dart';
import 'package:workmanager/workmanager.dart';

class PryerTimeService {
  LocatoinService locatoinService = LocatoinService();
  late LocationData userLocation;
  String? countryName;
  String? cityName;
  String? streetName;
  String? subLocality;

  DateTime date = DateTime.now();

  Future<void> setLocaleToArabic() async {
    await setLocaleIdentifier(AppValues.langCodeBase);
  }

  Future<PrayerTimes> calculatePrayerTime() async {
    userLocation = await locatoinService.getMyLoaction();
    Coordinates coordinates = Coordinates(userLocation.latitude!,
        userLocation.longitude!); // Replace with your own location lat, lng.
    await setLocaleToArabic();
    List<Placemark> placemarks = await placemarkFromCoordinates(
        userLocation.latitude!, userLocation.longitude!);

    subLocality = placemarks.first.subLocality;
    streetName = placemarks.first.street!.split('،').first;
    countryName = placemarks.first.country;
    cityName = placemarks.first.locality;

    final params = CalculationMethod.egyptian.getParameters();
    params.madhab = Madhab.shafi;

    DateComponents myDate = DateComponents(date.year, date.month, date.day);

    PrayerTimes prayerTimes = PrayerTimes(
      coordinates,
      myDate,
      params,
    );

    PrayerTimeModels prayerTimeModels =
        PrayerTimeModels.fromPrayerTimes(prayerTimes);

    return prayerTimes;
  }

  // Duration calUTFC() {
  //   DateTime now = DateTime.now();
  //   Duration standardOffset =
  //       const Duration(hours: 2); // Standard UTC+2 offset for Cairo
  //   Duration currentOffset = now.timeZoneOffset;

  //   bool isDst = currentOffset != standardOffset;
  //   Duration utcOffset = isDst ? Duration(hours: 3) : standardOffset;

  //   return utcOffset;
  // }

  // Future<void> getUtcOffset() async {
  //   LocationData? userLocation = await locatoinService.getMyLoaction();
  //   // Initialize timezone data
  //   tz_data.initializeTimeZones();

  //   userLocation = await locatoinService.getMyLoaction();
  //   await calculatePrayerTime();
  //   // Get place marks from coordinates
  //   List<Placemark> placemarks = await placemarkFromCoordinates(
  //       userLocation!.latitude!, userLocation!.longitude!);
  //   var countryName = placemarks.first.country;
  //   var cityName = placemarks.first.locality;
  //   var county_city_name = "${countryName}/${cityName}";
  //   log('the city name is : $county_city_name');
  // }
}
