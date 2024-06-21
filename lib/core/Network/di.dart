// we will use GetIt

import 'package:azzan/Features/HomeFeature/presentaion/cubit/home_cubit.dart';
import 'package:azzan/Features/HomeFeature/presentaion/prayer_times_servies.dart';
import 'package:azzan/core/Network/dio.dart';
import 'package:azzan/core/Network/sharred_pref.dart';
import 'package:azzan/Features/SplashFeature/presentaion/cubit/splash_cubit.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setUp() {
  //!external
  //!core
  // Preferecnes and DioManager
  getIt.registerLazySingleton(() => Preferences());
  getIt.registerLazySingleton(() => DioManager());
  getIt.registerLazySingleton(() => PryerTimeService());

  //! feature
  setupRepo();
  //!bloc
  setupBloc();
}

void setupRepo() {
  //getIt.registerSingleton<MovieRepo>(MovieRepoImp(getIt.get<DioManager>()));
}

void setupBloc() {
  getIt.registerFactory<HomeCubit>(() => HomeCubit());
//getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt.get()));
}
