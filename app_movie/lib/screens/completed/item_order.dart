import 'package:app_movie/common/style/color.dart';
import 'package:app_movie/common/style/fonts.dart';
import 'package:flutter/material.dart';

class ItemOrder extends StatelessWidget {
  final  String  label;
  final  String  text;

  const ItemOrder({Key key, this.label, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return   Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      margin: EdgeInsets.only(right: 8),
      child: RichText(text: TextSpan(
          text: '$label\n',
          style: TextStyle(color: Colors.grey, fontWeight: AppFontWeight.normal, fontSize: AppFontSize.label),
          children: [
            TextSpan(text: text,  style: TextStyle(color: AppColor.black.withOpacity(0.7), fontWeight: AppFontWeight.medium, fontSize: AppFontSize.text),)
          ]
      )),
    );
  }
}
