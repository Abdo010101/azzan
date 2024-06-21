import 'package:azzan/Features/HomeFeature/presentaion/cubit/home_cubit.dart';
import 'package:azzan/core/Utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TimeSection extends StatelessWidget {
  TimeSection({super.key, required this.commingHomeCubit});

  HomeCubit commingHomeCubit;

  @override
  Widget build(BuildContext context) {
    //TODO the space beteen two rich text solve this issue
    return Column(
      children: [
        Center(
          // color: Colors.green,
          child: RichText(
              text: TextSpan(children: [
            TextSpan(
                text: ' ${commingHomeCubit.getCurrentHijriMonthday()} ',
                style: Style.style16BOld),
            TextSpan(
                text: '${commingHomeCubit.getCurrentHijriMonthName()} ',
                style: Style.style16BOld),
            TextSpan(
                text: ' ${commingHomeCubit.getCurrentHijriYearName()} ',
                style: Style.style16BOld),
          ])),
        ),
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: ' ${commingHomeCubit.getDayName()} ', style: Style.style12),
          TextSpan(
              text: ' ${commingHomeCubit.getCurrentDayOfMonth()} ',
              style: Style.style12),
          TextSpan(
              text: '${commingHomeCubit.getMonthName()} ',
              style: Style.style12),
          TextSpan(
              text: ' ${commingHomeCubit.getYearName()} ',
              style: Style.style12),
        ])),
      ],
    );
  }
}
