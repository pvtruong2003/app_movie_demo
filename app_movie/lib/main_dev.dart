import 'package:app_movie/locator.dart';
import 'package:flutter/material.dart';
import 'main.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  setLocator();
  runApp(RestartContainer());
}