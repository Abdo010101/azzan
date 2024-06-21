import 'dart:developer';

import 'package:azzan/Features/HomeFeature/presentaion/cubit/home_cubit.dart';
import 'package:azzan/core/Network/di.dart';
import 'package:azzan/core/Utils/colors.dart';
import 'package:azzan/core/widgets/custom_switch_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemForPrayer extends StatelessWidget {
  ItemForPrayer(
      {super.key,
      required this.homeCubit,
      required this.whichPayer,
      required this.assetName,
      required this.isActive,
      required this.index});
  HomeCubit homeCubit;
  String whichPayer;
  String assetName;
  bool isActive;
  int index;
  HomeCubit myHomeCubit = getIt.get<HomeCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 8,
        decoration: ShapeDecoration(
            color: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image(image: AssetImage('${homeCubit.prayerIconsImages[index]}')),
              const SizedBox(
                width: 14,
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: '${homeCubit.prayerNames[index]} \n',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20)),
                TextSpan(text: '${homeCubit.listOfPrayerTimes[index]}')
              ])),
              const Spacer(),
              BlocBuilder<HomeCubit, HomeState>(
                bloc: myHomeCubit,
                builder: (context, state) {
                  return CustomSwitch(
                      value: myHomeCubit.switchButtonForEachPrayer[index],
                      onChanged: (bool val) {
                        myHomeCubit.changeTheSwitchButtonForEachPrayer(
                            index: index);
                      });
                },
              )
            ],
          ),
        ),
      );
    });
  }
}
