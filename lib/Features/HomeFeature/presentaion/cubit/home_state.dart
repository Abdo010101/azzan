part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeGetPrayerTimeLoading extends HomeState {}

class HomeGetPrayerTimeSuccess extends HomeState {}

class HomeCalcualtePryaerTimeLoading extends HomeState {}

class HomeCalcualtePryaerTimeSuccess extends HomeState {}

class HomeAcutalRealTimeLoading extends HomeState {}

class HomeAcutalRealTimeSuccess extends HomeState {}

class HomeCalTimeLoading extends HomeState {}

class HomeCalTimeSuccess extends HomeState {}

class HomeSwitchToggleLoading extends HomeState {}

class HomeSwitchToggleSuccess extends HomeState {}

class HomeSwitchToggleSuccesss extends HomeState {}

class HomeFindUpCommingPryaerLoading extends HomeState {}

class HomeFindUpCommingPryaerSuccess extends HomeState {}

class HomeCalDiffLoading extends HomeState {}

class HomeCalDiffSucces extends HomeState {}

class HomeSharrePrefChange extends HomeState {}

class HomeSharredPrefSuccess extends HomeState {}

class HomeGetSharredLoading extends HomeState {}

class HomeGetSharredSucess extends HomeState {}
