
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mvvm_architechture/presentation/resources/assets_manager.dart';
import 'package:mvvm_architechture/presentation/resources/color_manager.dart';
import 'package:mvvm_architechture/presentation/resources/constants_manager.dart';
import 'package:mvvm_architechture/presentation/resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  late Timer _timer;

  _startDelay(){
    _timer=Timer(const Duration(seconds: AppConstants.splashDelay),_goToScreen);
  }
  _goToScreen(){
    Navigator.pushReplacementNamed(context, Routes.onboarding);
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer.cancel();
    print("cancel timer");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(child: Image.asset(ImagesAsset.splashLogo),),
    );
  }
}