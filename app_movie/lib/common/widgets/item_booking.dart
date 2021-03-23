import 'package:app_movie/common/style/fonts.dart';
import 'package:flutter/material.dart';

class ItemBooking extends StatelessWidget {
final  String  label;
final  String  text;

  const ItemBooking({Key key, this.label, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return   Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      margin: EdgeInsets.only(right: 8),
      child: RichText(text: TextSpan(
          text: '$text\n',
          style: TextStyle(color: Colors.grey, fontWeight: AppFontWeight.medium, fontSize: AppFontSize.medium),
          children: [
            TextSpan(text: label,  style: TextStyle(color: Colors.black26, fontWeight: AppFontWeight.normal, fontSize: AppFontSize.text),)
          ]
      )),
    );
  }
}
