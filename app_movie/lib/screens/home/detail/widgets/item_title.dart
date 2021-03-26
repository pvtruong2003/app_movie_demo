import 'package:app_movie/common/style/color.dart';
import 'package:app_movie/common/style/fonts.dart';
import 'package:flutter/material.dart';

class ItemTitle extends StatelessWidget {
  final String title;
  final String text;

  const ItemTitle({Key key, this.title, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(top: 4, right: 16),
      child: RichText(text: TextSpan(
          text: '$title: ',
          style: TextStyle(color: Colors.blueGrey, fontSize: AppFontSize.label, fontWeight: AppFontWeight.normal),
          children: [
            TextSpan(text: text, style: TextStyle(color: AppColor.white, fontSize: AppFontSize.label, fontWeight: AppFontWeight.medium),
            )
          ]
      )),
    );
  }
}
