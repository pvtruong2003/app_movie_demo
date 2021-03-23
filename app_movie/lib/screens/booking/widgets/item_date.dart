import 'package:app_movie/common/style/fonts.dart';
import 'package:flutter/material.dart';

class ItemDate extends StatelessWidget {
  final String month;
  final String day;

  const ItemDate({Key key, this.month, this.day}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        margin: EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
            color: Colors.grey[100], borderRadius: BorderRadius.circular(12.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              month,
              style: TextStyle(
                  color: Colors.black26,
                  fontWeight: AppFontWeight.bold,
                  fontSize: 18),
            ),
            Text(
              day,
              style: TextStyle(
                  color: Colors.black26,
                  fontWeight: AppFontWeight.bold,
                  fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
