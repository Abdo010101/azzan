import 'dart:async';

import 'package:azzan/core/Routes/app_routes.dart';
import 'package:azzan/Features/SplashFeature/presentaion/cubit/splash_cubit.dart';
import 'package:azzan/core/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();
    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeOutCirc,
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(goHome: () {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.newHome, (route) => false);
      }),
      child: BlocBuilder<SplashCubit, SplashState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.primaryColor,
            body: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment(0.00, -1.00),
                    end: Alignment(0, 1),
                    colors: [
                      Color(0xFF1D5982),
                      Color(0xFF155072),
                      Color(0xFF07333B),
                      Color(0xFF00121D),
                      Color(0xFF020D14)
                    ],
                  )),
                ),
                Center(
                  child: Container(
                    child: FadeTransition(
                      opacity: _animation!,
                      child: ScaleTransition(
                        scale: _animation!,
                        child: Image.asset(
                            'assets/images/Frame.png'), // Replace with your image asset
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
