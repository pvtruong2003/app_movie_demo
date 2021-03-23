import 'package:app_movie/locator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'main.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setLocator();
  runApp(RestartContainer());
}