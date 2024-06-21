import 'dart:developer';

import 'package:adhan/adhan.dart';
import 'package:azzan/Features/HomeFeature/presentaion/cubit/home_cubit.dart';
import 'package:azzan/Features/HomeFeature/presentaion/widgets/item_for_prayer.dart';
import 'package:azzan/Features/HomeFeature/presentaion/widgets/shimmer_loading.dart';
import 'package:azzan/core/Network/di.dart';
import 'package:azzan/core/Utils/app_progress.dart';
import 'package:azzan/core/Utils/colors.dart';
import 'package:azzan/core/Utils/utils.dart';
import 'package:azzan/core/widgets/custom_switch_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:flutter/widgets.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:jhijri/_src/_jHijri.dart';
import 'package:jhijri/jHijri.dart';

class BodyHomeGetingPrayerWidget extends StatefulWidget {
  BodyHomeGetingPrayerWidget({super.key, required this.commingHomeCubit});
  HomeCubit commingHomeCubit;

  @override
  State<BodyHomeGetingPrayerWidget> createState() =>
      _BodyHomeGetingPrayerWidgetState();
}

class _BodyHomeGetingPrayerWidgetState
    extends State<BodyHomeGetingPrayerWidget> {
  List<String> myListPrayerTime = [];
  late HomeCubit myHomeCubit;
  late bool switchVal;
  late DateTime now;
  @override
  void initState() {
    super.initState();
    myHomeCubit = getIt.get<HomeCubit>();
    myHomeCubit.calDifferenc(widget.commingHomeCubit.timesForEachPrayerInEgypt[
        widget.commingHomeCubit.upcomingPrayerIndex!]);
    now = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 5,
              decoration: ShapeDecoration(
                color: Colors.white,
                shadows: [
                  BoxShadow(
                    color: AppColors.primaryColor
                        .withOpacity(0.5), // Color of the shadow
                    spreadRadius: 2, // Spread radius
                    blurRadius: 7, // Blur radius
                    offset: const Offset(0, 3), // Position of the shadow
                  ),
                ],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<HomeCubit, HomeState>(
                    bloc: myHomeCubit,
                    builder: (context, state) {
                      String currentPrayer =
                          widget.commingHomeCubit.prayerNames[
                              widget.commingHomeCubit.upcomingPrayerIndex!];
                      if (state is HomeCalDiffSucces) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('صلاه ${currentPrayer} بعد  '),
                            const SizedBox(
                              width: 10,
                            ),
                            Directionality(
                              textDirection: isArabic()
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                              child: TimerCountdown(
                                  secondsDescription: 'ثوانى',
                                  minutesDescription: 'دقايق',
                                  hoursDescription: 'ساعات',
                                  timeTextStyle: const TextStyle(
                                      color: AppColors.primaryColor),
                                  descriptionTextStyle: const TextStyle(
                                      color: AppColors.primaryColor),
                                  format:
                                      CountDownTimerFormat.hoursMinutesSeconds,
                                  endTime: DateTime.now()
                                      .add(myHomeCubit.timeUntilNextPryaer!)),
                            ),
                          ],
                        );
                      } else {
                        return const ShimmerLoadingPage();
                      }
                    },
                  )
                ],
              ),
            ),
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                  child: Text(
                      '${widget.commingHomeCubit.getCurrentHijriMonthday()} ${widget.commingHomeCubit.getCurrentHijriMonthName()}')),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: Text(
                      '${widget.commingHomeCubit.getCurrentDayOfMonth()} ${widget.commingHomeCubit.getMonthName()}')),
            ),
          ],
        ),
        SizedBox(
          height: 25.h,
        ),
        BlocBuilder<HomeCubit, HomeState>(
          bloc: myHomeCubit,
          builder: (context, state) {
            return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ItemForPrayer(
                    homeCubit: widget.commingHomeCubit,
                    whichPayer: widget.commingHomeCubit.prayerNames[index],
                    assetName: widget.commingHomeCubit.prayerIconsImages[index],
                    isActive: widget.commingHomeCubit.prayerSatatus[index],
                    index: index,
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 12.h,
                  );
                },
                itemCount: widget.commingHomeCubit.prayerNames.length);
          },
        ),
      ]),
    );
  }
}
