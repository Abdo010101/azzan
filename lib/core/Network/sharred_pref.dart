import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? sharedPreferences;

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic getData({
    required String key,
  }) {
    // if (sharedPreferences!.get(key) == null) {
    //   // return tokenId = '';
    // } else {
    return sharedPreferences!.get(key);
    //  }
  }

  static dynamic getListData({
    required String key,
  }) {
    // if (sharedPreferences!.get(key) == null) {
    //   // return tokenId = '';
    // } else {
    return sharedPreferences!.getStringList(key);
    //  }
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences!.setString(key, value);
    if (value is int) return await sharedPreferences!.setInt(key, value);
    if (value is bool) return await sharedPreferences!.setBool(key, value);
    if (value is List<String>)
      return await sharedPreferences!.setStringList(key, value);
    return await sharedPreferences!.setDouble(key, value);
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPreferences!.remove(key);
  }

  Future<void> saveBooleanList(List<bool> myList, String key) async {
    List<String> stringList =
        myList.map((bool value) => value ? '1' : '0').toList();
    log('eeeeeeeeeeeeeeeeeeeeeeeee');
    await sharedPreferences!.setStringList(key, stringList);
  }

  Future<List<bool>> loadBooleanList(String key) async {
    List<String>? stringList = sharedPreferences!.getStringList(key);
    if (stringList != null) {
      log('lllllsdfsdfdsfdsfsdw');
      return stringList.map((String value) => value == '1').toList();
    } else {
      log('gggggggggggggggggggggggggggg');
      return [true, true, true, true, true, true];
    }
  }
}
