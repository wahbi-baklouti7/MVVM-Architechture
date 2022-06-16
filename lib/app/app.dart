
import 'package:flutter/material.dart';
import 'package:mvvm_architechture/presentation/resources/routes_manager.dart';

class MyApp extends StatefulWidget {

  MyApp._internal();

  static final _instance =MyApp._internal();

  factory MyApp()=>_instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashScreen,
      
    );
  }
}