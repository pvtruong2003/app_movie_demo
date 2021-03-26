import 'package:app_movie/loading.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  static parseToDate({String date}) {
    if (date != null)
      return DateFormat("dd MMM yyyy")
          .format(DateFormat("yyyy-MM-dd").parse(date));
    else
      return 'No date';
  }
}
