// import 'dart:developer';

// import 'package:adhan/adhan.dart';
// import 'package:azzan/Features/HomeFeature/presentaion/cubit/home_cubit.dart';
// import 'package:azzan/Features/HomeFeature/presentaion/prayer_times_servies.dart';
// import 'package:azzan/Features/HomeFeature/presentaion/widgets/body_home_getting_prayer_widget.dart';
// import 'package:azzan/Features/HomeFeature/presentaion/widgets/shimmer_loading.dart';
// import 'package:azzan/core/Network/di.dart';
// import 'package:azzan/core/Service/local_notification_service.dart';
// import 'package:azzan/core/Utils/app_progress.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_timezone/flutter_timezone.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

// import 'package:timer_count_down/timer_count_down.dart';

// class HomeScreen extends StatefulWidget {
//   HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   late HomeCubit homeCubit;
//   late PryerTimeService pryerTimeService;
//   @override
//   void initState() {
//     super.initState();
//     homeCubit = getIt.get<HomeCubit>();
//     pryerTimeService = getIt.get<PryerTimeService>();
//     getPrayerTime();
//   }

//   getPrayerTime() async {
//     await homeCubit.getPrayerTimeSuccessFromCubit();
//     // homeCubit.calRemaingTimeCubit();
//     homeCubit.fillListWithThePrayerTimes();
//     homeCubit.prayerTimeInEgypt();
//     homeCubit.findUpcomingPrayer();

//     // final timeZone = await homeCubit.getTimeZoneFromCoordinates(
//     //     pryerTimeService.userLocation.latitude!,
//     //     pryerTimeService.userLocation.longitude!);
//     final String currentTimeZone = await FlutterTimezone.getLocalTimezone();

//     tz.setLocalLocation(tz.getLocation(currentTimeZone));
//     // TODO need to complete notification Configration for IOS

//     // LocalNotificationService.secduledNotification(
//     //     homeCubit.prayerTimes.dhuhr, 'dhar');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => HomeCubit(),
//       child: BlocBuilder<HomeCubit, HomeState>(
//         bloc: homeCubit,
//         builder: (context, state) {
//           if (state is HomeCalTimeSuccess ||
//               state is HomeAcutalRealTimeSuccess ||
//               state is HomeFindUpCommingPryaerSuccess ||
//               state is HomeCalDiffSucces) {
//             log('${pryerTimeService.cityName}');
//             log('${pryerTimeService.countryName}');
//             log(homeCubit.getMonthName());
//             log('${homeCubit.getCurrentDayOfMonth()}');
//             log(homeCubit.getCurrentHijriMonthName());
//             log('${homeCubit.getCurrentHijriMonthday()}');
//             log('${homeCubit.timesForEachPrayerInEgypt}');
//             log('${homeCubit.upcomingPrayerIndex}');
//             log('${homeCubit.upcomingPrayerTime}');

//             return Scaffold(
//                 body: SingleChildScrollView(
//               child: SafeArea(
//                 child: SizedBox(
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Row(
//                           children: [
//                             Image.asset('assets/images/Vector.png'),
//                             Padding(
//                               padding: const EdgeInsetsDirectional.symmetric(
//                                   horizontal: 5),
//                               child: Text('${pryerTimeService.cityName}'),
//                             ),
//                             const Spacer(),
//                             Image.asset('assets/images/ci_settings.png'),
//                           ],
//                         ),
//                       ),
//                       BodyHomeGetingPrayerWidget(
//                         commingHomeCubit: homeCubit,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ));
//           }
//           return const Scaffold(
//               body: SafeArea(
//                   child: Padding(
//             padding: EdgeInsets.all(16.0),
//             child: ShimmerLoadingPage(),
//           )));
//         },
//       ),
//     );
//   }
// }
