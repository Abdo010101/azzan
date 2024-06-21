import 'package:location/location.dart';

class LocatoinService {
  // * before acces location we need some steps
// *   1- inquire about loaciton service  in mobile phone it self
// *   2- request Permission
// *   3- GET location
// *   4- disply

  final Location _location = Location();

//* to handle the excption i do not wnat the functin to be bool
  Future<void> checkAndRequestLoactionService() async {
    //*check on the locatino service on the phone is one or not the request it if not enable   */
    bool isServiceEnable = await _location.serviceEnabled();
    if (!isServiceEnable) {
      isServiceEnable = await _location.requestService();
      if (!isServiceEnable) {
        throw LocationServiceException();
      }
    }
  }

  Future<void> checkAndRequestLoactionPermsiion() async {
    PermissionStatus permissionStatus = await _location.hasPermission();
    if (permissionStatus == PermissionStatus.deniedForever) {
      throw LocationPermissionException();
    }
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await _location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        // if he not allow to you to acces the laocitn

        throw LocationPermissionException();
      }
    }
  }

  void getRealTimeLoaction(void Function(LocationData)? onData) async {
    await checkAndRequestLoactionService();
    await checkAndRequestLoactionPermsiion();
    _location.changeSettings(distanceFilter: 2);
    _location.onLocationChanged.listen(onData);
  }

  Future<LocationData> getMyLoaction() async {
    await checkAndRequestLoactionService();
    await checkAndRequestLoactionPermsiion();
    return await _location.getLocation();
  }
}

class LocationServiceException implements Exception {}

class LocationPermissionException implements Exception {}
