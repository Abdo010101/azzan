import 'package:azzan/core/Utils/utils.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit({required this.goHome}) : super(SplashLoading()) {
    detrmineLocation();
  }

  final void Function() goHome;

  Future<void> detrmineLocation() async {
    await futureDelayed();
    goHome();
  }
}
