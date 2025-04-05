import 'package:employee_data/app/core/injection_container.dart';
import 'package:employee_data/my_app.dart';
import 'package:employee_data/utils/asset_resources.dart/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  init();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: CR.statusBarColor,
    statusBarIconBrightness: Brightness.dark,
  ));

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown, // Optional: allows upside-down portrait
  ]);

  runApp(const MyApp());
}
