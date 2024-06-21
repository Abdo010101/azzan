import 'dart:developer';

import 'package:azzan/Features/HomeFeature/presentaion/cubit/home_cubit.dart';
import 'package:azzan/core/Utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SunRiseAndMidDayAndSunSetWidget extends StatelessWidget {
  SunRiseAndMidDayAndSunSetWidget({super.key, required this.commingHomeCubit});
  final HomeCubit commingHomeCubit;

  final List<String> listOfSunRiseAndSunSet = ['شروق', 'منتصف اليوم', 'غروب'];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: constraints.maxWidth > 600
            ? const EdgeInsets.symmetric(vertical: 8.0)
            : const EdgeInsets.symmetric(vertical: 4.0),
        child: Container(
          height: MediaQuery.sizeOf(context).height / 9,
          width: double.infinity,
          decoration: ShapeDecoration(
              color: const Color(0xffF8F8F8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              )),
          child: Center(
            child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ItemForListView(
                    homeCubit: commingHomeCubit,
                    listOfSunRiseAndSunSet: listOfSunRiseAndSunSet,
                    listOfSunRiseAndSunSetDateTimes:
                        commingHomeCubit.listOfSunRiseAndSunSetDateTimes,
                    index: index,
                  );
                },
                separatorBuilder: (context, index) {
                  return Padding(
                      padding: constraints.maxWidth > 600
                          ? const EdgeInsets.symmetric(vertical: 10.0)
                          : const EdgeInsets.symmetric(vertical: 8),
                      child: customDivider());
                },
                itemCount: 3),
          ),
        ),
      );
    });
  }
}

Widget customDivider() {
  return Container(
    decoration: ShapeDecoration(
        color: const Color(0xFF0081C6).withOpacity(0.3),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
    width: 2,
  );
}

class ItemForListView extends StatelessWidget {
  const ItemForListView(
      {super.key,
      required this.listOfSunRiseAndSunSet,
      required this.homeCubit,
      required this.listOfSunRiseAndSunSetDateTimes,
      required this.index});

  final List<String> listOfSunRiseAndSunSet;
  final List<String> listOfSunRiseAndSunSetDateTimes;
  final int index;
  final HomeCubit homeCubit;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return LayoutBuilder(builder: (context, constraints) {
        return Container(
          padding: constraints.maxWidth > 600
              ? const EdgeInsets.symmetric(horizontal: 20)
              : const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ' ${listOfSunRiseAndSunSet[index]}',
                style: Style.style16,
              ),
              SizedBox(height: constraints.maxHeight < 100 ? 0 : 5),
              Text(
                ' ${listOfSunRiseAndSunSetDateTimes[index]}',
                style: Style.style14,
              ),
              SizedBox(height: constraints.maxHeight < 100 ? 0 : 5),
              // Text(
              //   'صباحا',
              //   style: Style.style8WithColor,
              // )
            ],
          ),
        );
      });
    });
  }
}
