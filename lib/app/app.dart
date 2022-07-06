
import 'package:flutter/material.dart';
import 'package:mvvm_architechture/presentation/resources/routes_manager.dart';
import 'package:mvvm_architechture/presentation/resources/theme_manager.dart';

class MyApp extends StatefulWidget {

  MyApp._internal();
  
  static final _instance =MyApp._internal();

  factory MyApp()=>_instance;
  int testvalue=0;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      theme: getAppTheme(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashScreen,
      
    );
  }
}