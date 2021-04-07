import 'package:app_movie/common/style/color.dart';
import 'package:app_movie/common/style/fonts.dart';
import 'package:flutter/material.dart';

class NavigatorScreen extends StatelessWidget {
  final VoidCallback onPressed;
  final String textButton;

  const NavigatorScreen({Key key, this.onPressed, this.textButton}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  MaterialButton(
      color: Colors.pink,
      minWidth: size.width,
      padding: EdgeInsets.all(14.0),
      //Remove space bottom
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onPressed: () => onPressed(),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0)),
      child: Text(
       textButton,
        style: TextStyle(
            color: AppColor.white,
            fontWeight: AppFontWeight.medium,
            fontSize: AppFontSize.medium),
      ),
    );
  }
}
