import 'package:app_movie/common/style/fonts.dart';
import 'package:flutter/material.dart';

class ItemTime extends StatelessWidget {
  final String time;

  const ItemTime({Key key, this.time}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      margin: EdgeInsets.only(right: 8,),
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(12.0)),
      child: Text(
        time,
        style: TextStyle(
            color: Colors.black26,
            fontWeight: AppFontWeight.bold,
            fontSize: 18),
      ),
    );
  }
}
