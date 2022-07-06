import 'package:flutter/material.dart';
import 'package:mvvm_architechture/app/app.dart';
import 'package:mvvm_architechture/app/di.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(MyApp());
}