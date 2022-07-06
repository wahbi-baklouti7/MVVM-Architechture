import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mvvm_architechture/app/app_prefs.dart';
import 'package:mvvm_architechture/app/di.dart';
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
  final AppPreferences _appPreferences = instance<AppPreferences>();

  _startDelay() {
    _timer =
        Timer(const Duration(seconds: AppConstants.splashDelay), _goToScreen);
  }

  _goToScreen() {
    _appPreferences.isLoggedIn().then((isLogged) {
      if (isLogged) {
        // navigate to main screen
        Navigator.pushReplacementNamed(context, Routes.mainRoute);
      } else {
        _appPreferences.isOnboardingViewed().then((isOnboarding) {
          if (isOnboarding) {
            // navigate to login screen
            Navigator.pushReplacementNamed(context, Routes.loginRoute);
          } else {
            // navigate to onboarding screen
            Navigator.pushReplacementNamed(context, Routes.onboarding);
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(
        child: Image.asset(ImagesAsset.splashLogo),
      ),
    );
  }
}
