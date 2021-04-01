import 'package:app_movie/common/style/color.dart';
import 'package:app_movie/common/style/fonts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemDate extends StatelessWidget {
  final DateTime dateTime;
  final Function(String date) onPressed;

  const ItemDate({Key key, this.dateTime, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String month = DateFormat("MMM").format(dateTime);
    String day = DateFormat("dd").format(dateTime);
    return GestureDetector(
      onTap: () {
        String date = DateFormat("dd/MM/yyyy").format(dateTime);
        onPressed(date);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 32),
        child: Center(
            child: Text(
              '$month  $day',
              style: TextStyle(
                  color: AppColor.white,
                  fontSize: AppFontSize.medium,
                  fontWeight: AppFontWeight.medium),
            )),
      ),
    );
  }
}
