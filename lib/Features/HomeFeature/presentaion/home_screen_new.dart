import 'dart:developer';

import 'package:adhan/adhan.dart';
import 'package:azzan/Features/HomeFeature/presentaion/cubit/home_cubit.dart';
import 'package:azzan/Features/HomeFeature/presentaion/prayer_times_servies.dart';
import 'package:azzan/Features/HomeFeature/presentaion/widgets/animated_transition_custom.dart';
import 'package:azzan/Features/HomeFeature/presentaion/widgets/body_home_getting_prayer_widget.dart';
import 'package:azzan/Features/HomeFeature/presentaion/widgets/shimmer_loading.dart';
import 'package:azzan/Features/HomeFeature/presentaion/widgets/sunRise_MidDay_SunSet_widget.dart';
import 'package:azzan/Features/HomeFeature/presentaion/widgets/time_section.dart';
import 'package:azzan/core/Network/di.dart';
import 'package:azzan/core/Network/sharred_pref.dart';
import 'package:azzan/core/Service/local_notification_service.dart';
import 'package:azzan/core/Service/location_service.dart';
import 'package:azzan/core/Utils/app_progress.dart';
import 'package:azzan/core/Utils/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:timer_count_down/timer_count_down.dart';

class HomeScreenNew extends StatefulWidget {
  HomeScreenNew({super.key});

  @override
  State<HomeScreenNew> createState() => _HomeScreenNewState();
}

class _HomeScreenNewState extends State<HomeScreenNew> {
  late HomeCubit homeCubit;
  late PryerTimeService pryerTimeService;

  @override
  void initState() {
    super.initState();
    homeCubit = getIt.get<HomeCubit>();
    pryerTimeService = getIt.get<PryerTimeService>();

    getPrayerTime();
  }

  getPrayerTime() async {
    await homeCubit.getPrayerTimeSuccessFromCubit();
    homeCubit.fillListWithThePrayerTimes();
    homeCubit.prayerTimeInEgypt();
    homeCubit.findUpcomingPrayer();
    homeCubit.getCurrentPrayerInArabic();
    homeCubit.calSunRiseAndMidDayAndSunSet();
    homeCubit.seduleNotifcationUsingWorkManager();
    homeCubit.loadBooleanListCubit();

    log('the notiication seheudleed done wbabababababbababab');

    // TODO need to complete notification Configration for IOS

    // if (homeCubit.switchButtonForEachPrayer[0] == true) {
    //   LocalNotificationService.secduledNotification(
    //       homeCubit.prayerTimes.fajr, 'الفجر');
    // }
    // if (homeCubit.switchButtonForEachPrayer[1] == true) {
    //   LocalNotificationService.secduledNotification(
    //       homeCubit.prayerTimes.sunrise, 'الشروق');
    // }
    // if (homeCubit.switchButtonForEachPrayer[2] == true) {
    //   LocalNotificationService.secduledNotification(
    //       homeCubit.prayerTimes.dhuhr, 'الظهر');
    // }

    // if (homeCubit.switchButtonForEachPrayer[3] == true) {
    //   LocalNotificationService.secduledNotification(
    //       homeCubit.prayerTimes.asr, 'العصر');
    // }

    // if (homeCubit.switchButtonForEachPrayer[4] == true) {
    //   LocalNotificationService.secduledNotification(
    //       homeCubit.prayerTimes.maghrib, 'المغرب');
    // }
    // if (homeCubit.switchButtonForEachPrayer[5] == true) {
    //   LocalNotificationService.secduledNotification(
    //       homeCubit.prayerTimes.isha, 'العشاء');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        bloc: homeCubit,
        builder: (context, state) {
          if (state is HomeCalTimeSuccess ||
              state is HomeAcutalRealTimeSuccess ||
              state is HomeFindUpCommingPryaerSuccess ||
              state is HomeCalDiffSucces ||
              state is HomeGetSharredSucess ||
              state is HomeSharredPrefSuccess) {
            log('${homeCubit.switchButtonForEachPrayer[1]}');
            log('${homeCubit.switchButtonForEachPrayer[3]}');
            log('${pryerTimeService.cityName}');
            log('${pryerTimeService.countryName}');

            // log('${homeCubit.getCurrentPrayerInArabic()}');
            // log('${homeCubit.getNextPrayerInArabic()}');
            // log('${homeCubit.prayerTimes.currentPrayer()}');
            // log(homeCubit.getMonthName());
            // log('${homeCubit.getCurrentDayOfMonth()}');
            // log(homeCubit.getCurrentHijriMonthName());
            // log('${homeCubit.getCurrentHijriMonthday()}');

            // log('${homeCubit.upcomingPrayerIndex}');
            // log('${homeCubit.upcomingPrayerTime}');
            // log('${homeCubit.switchButtonForEachPrayer}');

            // log('sdfsdfdsfs');
            // log('${homeCubit.timesForEachPrayerInEgypt}');

            return Scaffold(
                body: SafeArea(
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      TimeSection(
                        commingHomeCubit: homeCubit,
                      ),
                      NextAndNowPrayerTimeSectionWidget(
                        commingHomeCubit: homeCubit,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SunRiseAndMidDayAndSunSetWidget(
                        commingHomeCubit: homeCubit,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: FooterSectionForAllPrayerTimes(
                          commingHomeCubitl: homeCubit,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      )
                    ],
                  ),
                ),
              ),
            ));
          }
          return const Scaffold(
              body: SafeArea(
                  child: Padding(
            padding: EdgeInsets.all(16.0),
            child: ShimmerLoadingPage(),
          )));
        },
      ),
    );
  }
}
//****************************************************************************** */

class FooterSectionForAllPrayerTimes extends StatelessWidget {
  const FooterSectionForAllPrayerTimes(
      {super.key, required this.commingHomeCubitl});
  final HomeCubit commingHomeCubitl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
          color: const Color(0xFFF7F7F7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          )),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20),
            child: LocatinWidgetDetailWidget(
              homeCubit: commingHomeCubitl,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
              // height: MediaQuery.of(context).size.height / 2.4,
              child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ItemForListViewForPrayerTimesWidget(
                      commingHomeCubit: commingHomeCubitl,
                      index: index,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Divider(
                        thickness: 1,
                        color: const Color(0xFF0081C6).withOpacity(0.3),
                      ),
                    );
                  },
                  itemCount: commingHomeCubitl.prayerNames.length),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemForListViewForPrayerTimesWidget extends StatelessWidget {
  ItemForListViewForPrayerTimesWidget(
      {super.key, required this.commingHomeCubit, required this.index});
  final HomeCubit commingHomeCubit;
  final int index;

  HomeCubit? homeCubit = getIt.get<HomeCubit>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          SvgPicture.asset('assets/images/wi_sunrise.svg'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              commingHomeCubit.prayerNames[index],
              style: Style.style20WithColor,
            ),
          ),
          const Spacer(),

          Text(
            commingHomeCubit.listOfPrayerTimes[index],
            style: Style.style16,
          ),
          SizedBox(
            width: 20,
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
          //   child: index <= 1
          //       ? Text(
          //           ' صباحا',
          //           style: Style.style10withColor,
          //         )
          //       : Text(
          //           'مساء',
          //           style: Style.style10withColor,
          //         ),
          // ),
          BlocBuilder<HomeCubit, HomeState>(
            bloc: homeCubit,
            builder: (context, state) {
              return CustomAnimatedTrasnsion(
                index: index,
                commingHomeCubit: commingHomeCubit,
                firestImg: 'assets/images/Vector.svg',
                secondImg: 'assets/images/Bell.svg',
              );
            },
          ),
        ],
      ),
    );
  }
}

class LocatinWidgetDetailWidget extends StatelessWidget {
  const LocatinWidgetDetailWidget({
    super.key,
    required this.homeCubit,
  });
  final HomeCubit homeCubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SvgPicture.asset(
            'assets/images/zondicons_location.svg',
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              homeCubit.pryerTimeService.streetName.toString() ?? "مصر",
              style: Style.style16,
            ),
            Text(
              homeCubit.pryerTimeService.cityName.toString(),
              style: Style.style12withOpacity,
            ),
          ],
        ),
      ],
    );
  }
}

///**************************************************************************************************** */
class NextAndNowPrayerTimeSectionWidget extends StatelessWidget {
  NextAndNowPrayerTimeSectionWidget(
      {super.key, required this.commingHomeCubit});
  HomeCubit commingHomeCubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PayerNowContainerWidget(
          myHomecubit: commingHomeCubit,
        ),
        SizedBox(
          width: 10.w,
        ),
        PayerNextContainerWidget(
          myHomeCubit: commingHomeCubit,
        )
      ],
    );
  }
}

class PayerNowContainerWidget extends StatelessWidget {
  PayerNowContainerWidget({
    super.key,
    required this.myHomecubit,
  });
  HomeCubit myHomecubit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: MediaQuery.sizeOf(context).height / 5,
              decoration: ShapeDecoration(
                color: const Color(0xFFF6F6F6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  'assets/images/background.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   'الوقت الان',
                //   style: Style.style20,
                // ),
                Text(
                  myHomecubit.prayerNames[myHomecubit.currentPrayerIndex!]
                      .toString(),
                  style: Style.style24,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  myHomecubit!
                      .listOfPrayerTimes[myHomecubit.currentPrayerIndex!],
                  style: Style.style24forNumber,
                ),
                SizedBox(
                  height: 5.h,
                ),
                // Text(
                //   'حتى - ${myHomecubit.currentPrayerIndex! == 5 ? myHomecubit.listOfPrayerTimes[0] : myHomecubit.listOfPrayerTimes[myHomecubit.currentPrayerIndex! + 1]}  ',
                //   style: Style.style12,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PayerNextContainerWidget extends StatelessWidget {
  PayerNextContainerWidget({super.key, required this.myHomeCubit});

  HomeCubit myHomeCubit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              // width: MediaQuery.sizeOf(context).width / 2,
              height: MediaQuery.sizeOf(context).height / 5,
              decoration: ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.70, -0.71),
                  end: Alignment(-0.7, 0.71),
                  colors: [
                    Color(0xFF0087CF).withOpacity(0.2),
                    Color(0xFF1E5982).withOpacity(0.2)
                  ],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  'assets/images/background.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   'الوقت التالى ',
                //   style: Style.style20,
                // ),
                Text(
                  myHomeCubit.prayerNames[myHomeCubit.upcomingPrayerIndex!],
                  style: Style.style24,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  myHomeCubit
                      .listOfPrayerTimes[myHomeCubit.upcomingPrayerIndex!],
                  style: Style.style24forNumber,
                ),
                SizedBox(
                  height: 5.h,
                ),
                // Text(
                //   'حتى -  ${myHomeCubit.upcomingPrayerIndex == 5 ? myHomeCubit.listOfPrayerTimes[0] : myHomeCubit.listOfPrayerTimes[myHomeCubit.upcomingPrayerIndex! + 1]} ',
                //   style: Style.style12,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
