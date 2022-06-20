import 'package:flutter/material.dart';
import 'package:mvvm_architechture/presentation/forgot_password/forgot_password_view.dart';
import 'package:mvvm_architechture/presentation/login/login_view.dart';
import 'package:mvvm_architechture/presentation/main/main_view.dart';
import 'package:mvvm_architechture/presentation/onboarding/view/onboarding_view.dart';
import 'package:mvvm_architechture/presentation/register/register_view.dart';
import 'package:mvvm_architechture/presentation/resources/string_manager.dart';
import 'package:mvvm_architechture/presentation/splash/splash_view.dart';
import 'package:mvvm_architechture/presentation/store_details/store_details_view.dart';

class Routes {
  static const String splashScreen = "/";
  static const String loginRoute = "/loginRoute";
  static const String registerRoute = "/registerRoute";
  static const String onboarding = "/onboarding";
  static const String forgotPasswordRoute = "/forgetPasswordRoute";
  static const String mainRoute = "/mainRoute";
  static const String storeDetailsRoute = "/storeDetailsRoute";
}

class RouteGenerator {
  static Route<dynamic>? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.storeDetailsRoute:
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(title: const Text(AppString.noRoute)),
              body: const Center(child: Text(AppString.noRoute)),
            ));
  }
}
