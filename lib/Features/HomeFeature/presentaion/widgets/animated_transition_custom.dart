import 'dart:developer';

import 'package:azzan/Features/HomeFeature/presentaion/cubit/home_cubit.dart';
import 'package:azzan/core/Network/di.dart';
import 'package:azzan/core/Network/sharred_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAnimatedTrasnsion extends StatefulWidget {
  CustomAnimatedTrasnsion(
      {super.key,
      required this.commingHomeCubit,
      required this.index,
      required this.firestImg,
      required this.secondImg});

  String? firestImg;
  String? secondImg;
  final HomeCubit commingHomeCubit;
  int index;

  @override
  State<CustomAnimatedTrasnsion> createState() =>
      _CustomAnimatedTrasnsionState();
}

class _CustomAnimatedTrasnsionState extends State<CustomAnimatedTrasnsion> {
  late HomeCubit homeCubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeCubit = getIt.get<HomeCubit>();
    widget.commingHomeCubit.loadBooleanListCubit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            //! here must handle when the user clik on icon for notificaiton must handl it
            await widget.commingHomeCubit
                .changeTheSwitchButtonForEachPrayer(index: widget.index);
            await widget.commingHomeCubit.saveBooleanListCubit();
          },
          child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 50),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: widget
                      .commingHomeCubit.switchButtonForEachPrayer[widget.index]
                  ? SvgPicture.asset(
                      widget.firestImg!,
                      width: 23,
                      key: const ValueKey('first_image'),
                    ) // Change this path to your first image
                  : SvgPicture.asset(
                      widget.secondImg!,
                      width: 23,
                      key: const ValueKey('second_image'),
                    ) // Ch,
              ),
        );
      },
    );
  }
}
