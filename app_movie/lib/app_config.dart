import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
class AppConfig extends InheritedWidget {
  final String baseUrl;
  final String env;
  AppConfig({@required Widget child, @required this.baseUrl, this.env ='dev'}): super(child: child);

  static AppConfig of(BuildContext context) {
     return context.dependOnInheritedWidgetOfExactType<AppConfig>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

}