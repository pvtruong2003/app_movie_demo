import 'package:app_movie/app_container.dart';
import 'package:flutter/material.dart';

class DebugScreen extends StatelessWidget {
  static const routerName = 'debug-screen';
  @override
  Widget build(BuildContext context) {
    return AppContainer(
        appBar: AppBar(
          title: Text('Debug mode'),
        ),
        child: Container());
  }
}
