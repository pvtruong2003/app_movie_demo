import 'package:app_movie/common/style/color.dart';
import 'package:app_movie/common/style/fonts.dart';
import 'package:flutter/material.dart';

class TextFieldSearch extends StatelessWidget {
  final Function(String value) onSearch;

  const TextFieldSearch({Key key,@required this.onSearch}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (String value) {
         onSearch(value);
      },
      style: TextStyle(
          fontSize: AppFontSize.label,
          fontWeight: AppFontWeight.normal,
          color: AppColor.white),
      decoration: InputDecoration(
        hintText: 'Movie, Actor, Directors...',
        hintStyle: TextStyle(
            fontSize: AppFontSize.large,
            fontWeight: AppFontWeight.medium,
            color: AppColor.grayA6),
        contentPadding:
        EdgeInsets.symmetric(vertical: 12, horizontal: 0),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
      ),
    );
  }
}
