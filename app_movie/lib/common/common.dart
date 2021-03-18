import 'package:app_movie/loading.dart';
import 'package:flutter/material.dart';

class Common {
  static Future<void> showLoading(BuildContext context) async {
    showDialog<void>(
        context: context,
        builder: (BuildContext cxt) {
          return Loading();
        });
  }

  static Future<void> hideLoading(BuildContext context) async {
    Navigator.pop(context);
  }

  static Future<void> showMessage({String message}) async {
    // showDialog<void>(
    //     context: navigatorKey.currentState.overlay.context,
    //     builder: (BuildContext context) {
    //       return ShowError(message: message);
    //     });
  }
}
